[{assign var="oxConfig" value=$oView->getConfig()}]
[{assign var="currency" value=$oView->getActCurrency()}]
<link rel="stylesheet" type="text/css" href="[{ $oViewConf->getBaseDir() }]modules/paymill/paymill_styles.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
    var PAYMILL_PUBLIC_KEY = '[{$paymillPublicKey}]';
    var PAYMILL_AMOUNT = '[{$paymillAmount}]';
    var PAYMILL_CURRENCY = '[{$currency->name}]';
    var PAYMILL_FASTCHECKOUT_CC = [{$fastCheckoutCc}];
    var PAYMILL_FASTCHECKOUT_ELV = [{$fastCheckoutElv}];
    var PAYMILL_DEBUG = '[{$oxConfig->getShopConfVar('PAYMILL_ACTIVATE_DEBUG')}]';
</script>
<script type="text/javascript" src="https://bridge.paymill.com/"></script>
<script type="text/javascript">
$.noConflict();
jQuery(document).ready(function ($) 
{
    $('#paymillCardNumber').keyup(function() 
    {
        var brand = paymill.cardType($('#paymillCardNumber').val());
            brand = brand.toLowerCase();
            switch(brand){
                case 'visa':
                    $('.card-icon').html('<img src="[{ $oViewConf->getBaseDir() }]modules/paymill/image/32x20_visa.png" >');
                    $('.card-icon').show();
                    break;
                case 'mastercard':
                    $('.card-icon').html('<img src="[{ $oViewConf->getBaseDir() }]modules/paymill/image/32x20_mastercard.png" >');
                    $('.card-icon').show();
                    break;
                case 'american express':
                    $('.card-icon').html('<img src="[{ $oViewConf->getBaseDir() }]modules/paymill/image/32x20_amex.png" >');
                    $('.card-icon').show();
                    break;
                case 'jcb':
                    $('.card-icon').html('<img src="[{ $oViewConf->getBaseDir() }]modules/paymill/image/32x20_jcb.png" >');
                    $('.card-icon').show();
                    break;
                case 'maestro':
                    $('.card-icon').html('<img src="[{ $oViewConf->getBaseDir() }]modules/paymill/image/32x20_maestro.png" >');
                    $('.card-icon').show();
                    break;
                case 'diners club':
                    $('.card-icon').html('<img src="[{ $oViewConf->getBaseDir() }]modules/paymill/image/32x20_dinersclub.png" >');
                    $('.card-icon').show();
                    break;
                case 'discover':
                    $('.card-icon').html('<img src="[{ $oViewConf->getBaseDir() }]modules/paymill/image/32x20_discover.png" >');
                    $('.card-icon').show();
                    break;
                case 'unionpay':
                    $('.card-icon').html('<img src="[{ $oViewConf->getBaseDir() }]modules/paymill/image/32x20_unionpay.png" >');
                    $('.card-icon').show();
                    break;
                case 'unknown':
                default:
                    $('.card-icon').hide();
                    break;
            }
            
            $('.card-icon :first-child').css('position','absolute');

    });

    function PaymillResponseHandler(error, result) 
    {
        if (error) {
            paymillDebug('An API error occured:' + error.apierror);
            // Zeigt den Fehler überhalb des Formulars an
            $(".payment-errors").text(error.apierror);
            $(".payment-errors").css("display","inline-block");
        } else {
            $(".payment-errors").css("display","none");
            $(".payment-errors").text("");
            // Token
            paymillDebug('Received a token: ' + result.token);
            // Token in das Formular einfügen damit es an den Server übergeben wird
            $("#payment").append("<input type='hidden' name='paymillToken' value='" + result.token + "'/>");
            $("#payment").get(0).submit();
        }
        
        $("#paymentNextStepBottom").removeAttr("disabled");
    }

    function paymillDebug(message)
    {
        if(PAYMILL_DEBUG === "1"){
            console.log(message);
        }
    }

    $("#payment").submit(function (event) 
    {
        // Absenden Button deaktivieren um weitere Klicks zu vermeiden
        $('#paymentNextStepBottom').attr("disabled", "disabled");
        paymillDebug('Paymill: Start form validation');
        if ($('#payment_paymill_cc').attr('checked')) {
            if (!PAYMILL_FASTCHECKOUT_CC) {
                if (!paymill.validateCardNumber($('#paymillCardNumber').val())) {
                    $(".payment-errors.cc").text('[{ oxmultilang ident="PAYMILL_VALIDATION_CARDNUMBER" }]');
                    $(".payment-errors.cc").css("display","inline-block");
                    $("#paymentNextStepBottom").removeAttr("disabled");
                    return false;
                }

                if (!paymill.validateExpiry($('#paymillCardExpiryMonth').val(), $('#paymillCardExpiryYear').val())) {
                    $(".payment-errors.cc").text('[{ oxmultilang ident="PAYMILL_VALIDATION_EXP" }]');
                    $(".payment-errors.cc").css("display","inline-block");
                    $("#paymentNextStepBottom").removeAttr("disabled");
                    return false;
                }

                if (!paymill.validateCvc($('#paymillCardCvc').val(), $('#paymillCardNumber').val())) {
                    $(".payment-errors.cc").text('[{ oxmultilang ident="PAYMILL_VALIDATION_CVC" }]');
                    $(".payment-errors.cc").css("display","inline-block");
                    $("#paymentNextStepBottom").removeAttr("disabled");
                    return false;
                }

                if (!paymill.validateHolder($('#paymillCardHolderName').val())) {
                    $(".payment-errors.cc").text('[{ oxmultilang ident="PAYMILL_VALIDATION_CARDHOLDER" }]');
                    $(".payment-errors.cc").css("display","inline-block");
                    $("#paymentNextStepBottom").removeAttr("disabled");
                    return false;
                }

                var params = {
                    amount_int: PAYMILL_AMOUNT,  // E.g. "15" for 0.15 Eur
                    currency: PAYMILL_CURRENCY,    // ISO 4217 e.g. "EUR"
                    number: $('#paymillCardNumber').val(),
                    exp_month: $('#paymillCardExpiryMonth').val(),
                    exp_year: $('#paymillCardExpiryYear').val(),
                    cvc: $('#paymillCardCvc').val(),
                    cardholder: $('#paymillCardHolderName').val()
                };
                paymill.createToken(params, PaymillResponseHandler);
            } else {
                $("#payment").append("<input type='hidden' name='paymillToken' value='dummyToken'/>");
                $("#payment").get(0).submit();
            }
        } else if($('#payment_paymill_elv').attr('checked')) {
            if (!PAYMILL_FASTCHECKOUT_ELV) {
                if (!$('#paymillElvHolderName').val()) {
                    $(".payment-errors.elv").text('[{ oxmultilang ident="PAYMILL_VALIDATION_ACCOUNTHOLDER" }]');
                    $(".payment-errors.elv").css("display","inline-block");
                    $("#paymentNextStepBottom").removeAttr("disabled");
                    return false;
                }

                if (!paymill.validateAccountNumber($('#paymillElvAccount').val())) {
                    $(".payment-errors.elv").text('[{ oxmultilang ident="PAYMILL_VALIDATION_ACCOUNTNUMBER" }]');
                    $(".payment-errors.elv").css("display","inline-block");
                    $("#paymentNextStepBottom").removeAttr("disabled");
                    return false;
                }

                if (!paymill.validateBankCode($('#paymillElvBankCode').val())) {
                    $(".payment-errors.elv").text('[{ oxmultilang ident="PAYMILL_VALIDATION_BANKCODE" }]');
                    $(".payment-errors.elv").css("display","inline-block");
                    $("#paymentNextStepBottom").removeAttr("disabled");
                    return false;
                }

                var params = {
                    number: $('#paymillElvAccount').val(),
                    bank: $('#paymillElvBankCode').val(),
                    accountholder: $('#paymillElvHolderName').val()
                };
                paymill.createToken(params, PaymillResponseHandler);
            } else {
                $("#payment").append("<input type='hidden' name='paymillToken' value='dummyToken'/>");
                $("#payment").get(0).submit();
            }
        } else{
            $("#paymentNextStepBottom").removeAttr("disabled");
            return true;
        }
        
        return false;
    });
});
</script>
[{$smarty.block.parent}]