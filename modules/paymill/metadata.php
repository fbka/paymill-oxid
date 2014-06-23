<?php

$sMetadataVersion = '1.1';
$aModule = array(
    'id' => 'paymill',
    'title' => 'Paymill',
    'description' => 'Paymill Payment',
    'thumbnail' => 'image/logo.png',
    'version' => '2.6.0',
    'author' => 'Paymill GmbH',
    'url' => 'http://www.paymill.de',
    'email' => 'support@paymill.de',
    'extend' => array(
        'payment' => 'paymill/controllers/paymill_payment',
        'oxpaymentgateway' => 'paymill/controllers/paymill_paymentgateway',
        'oxemail' => 'paymill/core/paymill_oxemail'
    ),
    'files' => array(
        'Services_Paymill_PaymentProcessor' => 'paymill/lib/Services/Paymill/PaymentProcessor.php',
        'Services_Paymill_LoggingInterface' => 'paymill/lib/Services/Paymill/LoggingInterface.php',
        'Services_Paymill_Clients' => 'paymill/lib/Services/Paymill/Clients.php',
        'Services_Paymill_Payments' => 'paymill/lib/Services/Paymill/Payments.php',
        'Services_Paymill_Transactions' => 'paymill/lib/Services/Paymill/Transactions.php',
        'Services_Paymill_Webhooks' => 'paymill/lib/Services/Paymill/Webhooks.php',
        'paymill_fastcheckout' => 'paymill/core/paymill_fastcheckout.php',
        'paymill_logging' => 'paymill/core/paymill_logging.php',
        'paymill_loglist' => 'paymill/core/paymill_loglist.php',
        'paymill_install' => 'paymill/controllers/admin/paymill_install.php',
        'paymill_log' => 'paymill/controllers/admin/paymill_log.php',
        'paymill_log_list' => 'paymill/controllers/admin/paymill_log_list.php',
        'paymill_log_entry' => 'paymill/controllers/admin/paymill_log_entry.php',
        'paymill_hooks' => 'paymill/controllers/paymill_hooks.php',
        'paymill_log_abstract' => 'paymill/controllers/admin/paymill_log_abstract.php',
        'paymill_register_hook' => 'paymill/controllers/admin/paymill_register_hook.php',
        'paymill_util' => 'paymill/util/paymill_util.php'
    ),
    'blocks' => array(
        array('template' => 'page/checkout/payment.tpl', 'block' => 'select_payment', 'file' => 'paymill_select_payment.tpl'),
        array('template' => 'page/checkout/payment.tpl', 'block' => 'mb_select_payment', 'file' => 'paymill_mb_select_payment.tpl'),
        array('template' => 'page/checkout/payment.tpl', 'block' => 'checkout_payment_main', 'file' => 'paymill_select_header.tpl'),
        array('template' => 'email/html/order_cust.tpl', 'block' => 'email_html_order_cust_paymentinfo', 'file' => 'paymill_html_order_cust.tpl'),
        array('template' => 'email/plain/order_cust.tpl', 'block' => 'email_plain_order_cust_paymentinfo', 'file' => 'paymill_plain_order_cust.tpl')
    ),
    'templates' => array(
        'paymill_cc.tpl' => 'paymill/views/azure/tpl/page/checkout/inc/paymill_cc.tpl',
        'paymill_elv.tpl' => 'paymill/views/azure/tpl/page/checkout/inc/paymill_elv.tpl',
        'paymill_mb_cc.tpl' => 'paymill/views/mobile/tpl/page/checkout/inc/paymill_mb_cc.tpl',
        'paymill_mb_elv.tpl' => 'paymill/views/mobile/tpl/page/checkout/inc/paymill_mb_elv.tpl',
        'paymill_install.tpl' => 'paymill/views/admin/tpl/paymill_install.tpl',
        'paymill_log.tpl' => 'paymill/views/admin/tpl/paymill_log.tpl',
        'paymill_log_list.tpl' => 'paymill/views/admin/tpl/paymill_log_list.tpl',
        'paymill_log_entry.tpl' => 'paymill/views/admin/tpl/paymill_log_entry.tpl',
        'paymill_register_hook.tpl' => 'paymill/views/admin/tpl/paymill_register_hook.tpl'
    ),
    'settings' => array(
        array('group' => 'main', 'name' => 'PAYMILL_PRIVATEKEY', 'type' => 'str', 'value' => ''),
        array('group' => 'main', 'name' => 'PAYMILL_PUBLICKEY', 'type' => 'str', 'value' => ''),
        array('group' => 'main', 'name' => 'PAYMILL_ACTIVATE_DEBUG', 'type' => 'bool', 'value' => 'false'),
        array('group' => 'main', 'name' => 'PAYMILL_ACTIVATE_LOGGING', 'type' => 'bool', 'value' => 'false'),
        array('group' => 'main', 'name' => 'PAYMILL_ACTIVATE_DIFFERENTAMOUNT', 'type' => 'str', 'value' => 0),
        array('group' => 'main', 'name' => 'PAYMILL_ACTIVATE_FASTCHECKOUT', 'type' => 'bool', 'value' => 'false'),
        array('group' => 'main', 'name' => 'PAYMILL_SET_PAYMENTDATE', 'type' => 'bool', 'value' => 'true'),
        array('group' => 'main', 'name' => 'PAYMILL_PRENOTIFICATION', 'type' => 'str', 'value' => '7'),
        array('group' => 'cc', 'name' => 'PAYMILL_VISA', 'type' => 'bool', 'value' => 'true', 'position' => 1),
        array('group' => 'cc', 'name' => 'PAYMILL_MASTERCARD', 'type' => 'bool', 'value' => 'true', 'position' => 2),
        array('group' => 'cc', 'name' => 'PAYMILL_AMEX', 'type' => 'bool', 'value' => 'true', 'position' => 3),
        array('group' => 'cc', 'name' => 'PAYMILL_CARTA_SI', 'type' => 'bool', 'value' => 'true', 'position' => 4),
        array('group' => 'cc', 'name' => 'PAYMILL_CARTE_BLEUE', 'type' => 'bool', 'value' => 'true', 'position' => 5),
        array('group' => 'cc', 'name' => 'PAYMILL_DINERSCLUB', 'type' => 'bool', 'value' => 'true', 'position' => 6),
        array('group' => 'cc', 'name' => 'PAYMILL_JCB', 'type' => 'bool', 'value' => 'true', 'position' => 7),
        array('group' => 'cc', 'name' => 'PAYMILL_MAESTRO', 'type' => 'bool', 'value' => 'true', 'position' => 8),
        array('group' => 'cc', 'name' => 'PAYMILL_UNIONPAY', 'type' => 'bool', 'value' => 'true', 'position' => 9),
        array('group' => 'cc', 'name' => 'PAYMILL_DISCOVER', 'type' => 'bool', 'value' => 'true', 'position' => 10),
        array('group' => 'cc', 'name' => 'PAYMILL_DANKORT', 'type' => 'bool', 'value' => 'true', 'position' => 11)
    )
);
