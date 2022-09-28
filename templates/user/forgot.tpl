{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
{extends file='layout.tpl'}

{block name=body}

    <style type="text/css">

        #breadcrumb {
            padding: 0;
        }
    </style>

    <div id="breadcrumb" class="col-md-12">

        <div class="codo_breadcrumb_list btn-breadcrumb hidden-xs">                
            {"block_breadcrumbs_before"|load_block}
            <a href="{$smarty.const.RURI}{$site_url}"><div>{$home_title}</div></a>
            <a href="{$smarty.const.RURI}user/login"><div>{_t("User login")}</div></a>
            <a href="#">{$sub_title}</a>
            {"block_breadcrumbs_after"|load_block}
        </div>
    </div>

    <div class="container">

        <div class="row">

            <div id='codo_new_password_resp' class='codo_notification' style="display: none"></div>

            {"block_forgot_form_before"|load_block}  
            <div class="codo_block col-md-12">

                {"block_forgot_form_start"|load_block}  
                <div class="row">

                    <div class="col-md-6">            
                        <input class="codo_input" type="text" id="name" maxlength="60" placeholder="{_t('username or e-mail address')}" required="">
                    </div>

                </div>

                <div class='row'>

                    <div class='col-md-6'>

                        <button id='req_pass' class='codo_btn codo_btn_primary'>{_t('E-mail reset token')}</button>
                        <img id="codo_sending_mail" style="display: none" src="{$smarty.const.CURR_THEME}img/ajax-loader.gif" />
                    </div>
                </div>
                {"block_forgot_form_end"|load_block}                  
            </div>
            {"block_forgot_form_after"|load_block}  

        </div>
    </div>
    <script type="text/javascript">

        function on_codo_loaded() {

            jQuery('document').ready(function ($) {

                //keep initial focus
                $('#name').focus();

                $('input').bind('keypress', function (e) {

                    var code = e.keyCode || e.which;
                    if (code === 13) { //Enter keycode

                        $('#req_pass').trigger('click');
                    }
                });


                $('#req_pass').on('click', function () {

                    $('#codo_sending_mail').show();
                    $.getJSON(
                            codo_defs.url + 'Ajax/user/login/req_pass',
                            {
                                ident: $.trim($('#name').val()),
                                token: codo_defs.token
                            },
                    function (response) {

                        $('#codo_sending_mail').hide();
                        CODOF.util.update_response_status(response, $('#codo_new_password_resp'), true);
                    }
                    );

                });


            });
        }
    </script>

{/block}