[{assign var="oxConfig" value=$oView->getConfig()}]
<dl>
    <dt>
        <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked[{/if}]>
        <label for="payment_[{$sPaymentID}]">
            <b>[{ $paymentmethod->oxpayments__oxdesc->value}]
            [{if $paymentmethod->getPrice()}]
                        [{if $oxcmp_basket->getPayCostNet()}]
                            ([{$paymentmethod->getFNettoPrice()}] [{$currency->sign}] [{oxmultilang ident="PAGE_CHECKOUT_BASKETCONTENTS_PLUSTAX1"}] [{$paymentmethod->getFPriceVat()}] )
                        [{else}]
                            ([{$paymentmethod->getFBruttoPrice()}] [{$currency->sign}])
                        [{/if}]
             [{/if}]
            </b>
        </label>
    </dt>
    <dd class="[{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]activePayment[{/if}]">
        <ul class="form">
            <li class="controls controls-row">
                <p class="payment-errors cc" style="display:none;"></p>
                <div>
                    <ul id="paymill_brands">
                        [{foreach key=brandsId from=$paymillBrands item=cardBrand name=paymillBrandSelect}]
                            <li class="paymill-card-number-[{$cardBrand}]"></li>
                        [{/foreach}]
                    </ul>
                </div>
                [{if $fastCheckoutCc == 'true'}]
                    <table id="paymillFastCheckoutTable">
                        <tr>
                            <td>[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_NUMBER" }]: </td>
                            <td id="paymillFcCardNumber" class="paymill-card-number-[{$brand}]">[{$paymillCcLastFour}]</td>
                        </tr>
                        <tr>
                            <td>[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_SECURITYCODE" }]: </td>
                            <td>[{$paymillCcCvc}]</td>
                        </tr>
                        <tr>
                            <td>[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_HOLDERNAME" }]: </td>
                            <td>[{$paymillCcCardHolder}]</td>
                        </tr>
                        <tr>
                            <td>[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_VALIDUNTIL" }]: </td>
                            <td>[{$paymillCcExpireMonth}]/[{$paymillCcExpireYear}]</td>
                        </tr>
                        <tr>
                        <td></td>
                        <td>
                        <button id="paymillFastCheckoutIframeChange" type="button">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_IFRAME_CHANGE" }]</button>
                        </td>
                        </tr>
                    </table>
                [{/if}]
                <div id="payment-form-cc">
                </div>
            </li>
        </ul>
        [{block name="checkout_payment_longdesc"}]
            [{if $paymentmethod->oxpayments__oxlongdesc->value}]
                <div class="desc">
                    [{$paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                </div>
            [{/if}]
        [{/block}]
    </dd>
</dl>
