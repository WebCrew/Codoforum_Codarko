{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
{extends file='layout.tpl'}

{block name=body}
    <style type="text/css">

        .codo_login_register_link {

            margin-right: 5px;
        }

        .remember_me_txt {

            color: grey;
        }

        #codo_login_error {

            padding: 10px;
            display: none;
        }

        #breadcrumb {

            padding: 0;
        }

        body {

            overflow-x: hidden;
        }

        .CODOFORUM {

            padding-bottom: 293px;
        }

    </style>
    <div id="breadcrumb" class="col-md-12">

        <div class="codo_breadcrumb_list btn-breadcrumb hidden-xs">
            {"block_breadcrumbs_before"|load_block}
            <a href="{$smarty.const.RURI}{$site_url}">
                <div><i class="glyphicon glyphicon-home"></i></div>
            </a>
            {"block_breadcrumbs_after"|load_block}
        </div>
    </div>
    <div class="container">

        <div class="row">


            {if !$can_view_forum}
                <div class="codo_notification codo_notification_error col-md-12">

                    {_t("You need to login to view the forum")}
                </div>
            {/if}

            {if $came_from_topic eq 'yes'}
                <div class="codo_notification codo_notification_warning col-md-12">

                    You need to be logged in to reply
                </div>
            {/if}


            <div id="codo_login_error"
                 class="codo_notification codo_notification_error col-md-12">{_t("Please fill both the fields!")}</div>

            {"block_login_form_before"|load_block}

            <div id="codo_login_container" class="codo_block col-md-12">
                {"block_login_form_start"|load_block}

                <div class="row">

                    <div class="col-md-6">
                        <input class="codo_input" type="text" id="name" maxlength="60" placeholder="{$name_placeholder}"
                               required="required"/>
                    </div>

                </div>
                <div class="row">

                    <div class="col-md-6">
                        <input class="codo_input" type="password" id="pass" maxlength="128"
                               placeholder="{_t("password")}" required="required"/>
                    </div>

                </div>

                <div class="row">

                    <div class="col-md-12">
                        <input id="remember_me" type="checkbox"/><span
                                class="remember_me_txt">{_t(" Keep me logged in")}</span>
                        <button class="codo_btn codo_btn_primary" id="codo_login">{_t("Login")}</button>
                    </div>

                </div>


                <div class="row">

                    <div class="col-md-6">
                        <a class="codo_login_register_link" href="{$register_url}">{_t("Register")}</a>
                        <a href="{$smarty.const.RURI}user/forgot">{_t("I forgot my password")}</a>
                    </div>


                </div>
                {"block_login_form_end"|load_block}

            </div>
            {"block_login_form_after"|load_block}

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

                        $('#codo_login').trigger('click');
                    }
                });


                $('#codo_login').on('click', function () {

                    //if (!CODOF.authenticator) {

                    //No alternative authenticator exists so use default
                    $.getJSON(
                        codo_defs.url + 'Ajax/user/login/dologin',
                        {
                            identifier: $.trim($('#name').val()),
                            password: $.trim($('#pass').val()),
                            remember: $('#remember_me').is(":checked"),
                            token: codo_defs.token
                        },
                        function (response) {

                            if (response.msg === "success") {
                                window.location.href = response.redirect;
                            } else {

                                $('#codo_login_error').html(response.msg).show('slow');
                                CODOF.ui.saccade($('#codo_login_error'));
                            }
                        }
                    );

                    // }
                });


            });

        }
        ;

    </script>
{/block}
