{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
{extends file='layout.tpl'}

{block name=body}

    <style type="text/css">

        body {
            overflow-x: hidden;
        }
        .codo_reg_error {
            position: absolute;
            background: #d14836;
            border: 1px solid #d14836;
            color: white;
            padding: 5px;
            border-radius: 1px;
            display: none;
        }

        .codo_reg_error_block .codo_reg_error {

            position: static;
            display: block;

        }

        #password {

            padding-right: 27px;
        }

        #codo_reg_pass {
            position: relative;
        }
        #letterViewer {
            position: absolute;
            right: -72px;
            top: 0;
            width: 100px;
            font: bold 30px Helvetica, Sans-Serif;
        }

        .codo_already_registered {

            color: #585858;
            display: inline-block;
            margin-left: 4px;
        }

        #breadcrumb {

            padding: 0;
        }

        .container {

            padding-top: 76px;
        }


    </style>

    <div id="breadcrumb" class="col-md-12">

        <div class="codo_breadcrumb_list btn-breadcrumb hidden-xs">
            {"block_breadcrumbs_before"|load_block}
            <a href="{$smarty.const.RURI}{$site_url}"><div><i class="glyphicon glyphicon-home"></i></div></a>
                        {"block_breadcrumbs_after"|load_block}
        </div>
    </div>

    <div class="container">

        <div class="row">

            {"block_register_form_before"|load_block}

            <div class="codo_block col-md-12">

                {if !empty($errors)}
                    <div class="codo_reg_error_block">
                        {foreach from=$errors item=error}
                            <div class='codo_reg_error'> {$error} </div>

                        {/foreach}
                    </div>
                {/if}

                {"block_register_form_start"|load_block}
                <form id="codo_register_form" action="{$smarty.const.RURI}user/register" method="POST" >
                    <div class="row">

                        <div class="col-md-6">
                            <input data-length="{$min_username_len}" value="{$register->username|escape}" class="codo_input" id="reg_username" type="text" name="username" placeholder="{_t("username")}" required/>
                            <div class="codo_reg_error"></div>
                        </div>

                    </div>
                    <div class="row">

                        <div class="col-md-6">
                            <div id="codo_reg_pass">
                                <input data-length="{$min_pass_len}" value="{$register->password|escape}" class="codo_input" id="password" type="password" name="password" placeholder="{_t("password")}" required/>
                                <div class="codo_reg_error"></div>
                            </div>

                        </div>

                    </div>

                    <div class="row">

                        <div class="col-md-6">
                            <input value="{$register->mail|escape}" class="codo_input" type="email" id="reg_mail" name="mail" placeholder="{_t("email")}" required=""/>
                            <div class="codo_reg_error"></div>
                        </div>

                    </div>


                    {foreach from=$custom_fields item=field}


                        <div class="row" id="custom_field_{$field.id}">
                            <div class="col-md-6">


                                {if $field.type eq 'input'}
                                    <input value="{$field.def_val|escape}" class="codo_input" type="{$field.input_type}" name="input_{$field.id}" placeholder="{_t({$field.title})}"
                                           {if !($field.input_length eq 0)} maxlength="{$field.input_length}"{/if}
                                           {if $field.is_mandatory}required=""{/if}/>

                                {else}
                                    <div class="form-group">
                                        {if $field.title}
                                            <label for="{$field.title}" >{$field.title}</label>
                                        {/if}

                                        {if $field.type eq 'radio'}
                                            {foreach from=$field.data.options item=text}

                                                <div class="radio">
                                                    <label>
                                                        <input
                                                            {if $field.def_val eq $text}checked="checked"{/if}
                                                            {if $field.is_mandatory}required=""{/if}
                                                            type="radio" name="input_{$field.id}"/>{_t({$text})}
                                                    </label>
                                                </div>
                                            {/foreach}

                                        {else if $field.type eq 'dropdown'}
                                            <select class="form-control" {if $field.is_mandatory}required=""{/if} name="input_{$field.id}">

                                                {foreach from=$field.data.options item=text}

                                                    <option {if $field.def_val eq $text}selected="selected"{/if}>{_t({$text})}</option>
                                                {/foreach}
                                            </select>
                                        {else if $field.type eq 'checkbox'}
                                            {foreach from=$field.data.options item=text}

                                                <div class="checkbox">
                                                    <label>
                                                        <input {if $field.def_val eq $text}checked="checked"{/if}
                                                            {if $field.is_mandatory}required=""{/if} type="checkbox" name="input_{$field.id}[]" />{_t({$text})}
                                                    </label>
                                                </div>
                                            {/foreach}

                                        {else if $field.type eq 'textarea'}

                                            <textarea {if $field.is_mandatory}required=""{/if} name="input_{$field.id}">{$field.def_val|escape}</textarea>
                                        {/if}
                                    </div>
                                {/if}

                            </div>
                        </div>
                    {/foreach}

                    {if isset($recaptcha)}
                        <div class="row col-md-12">

                            {$recaptcha}
                        </div>
                    {/if}



                    <input type="hidden" name="token" value="{$CSRF_token}" />
                    <div class="row">

                        <div class="col-md-12">
                            <button class="codo_btn codo_btn_primary" id="codo_register">{_t("Register")}</button>
                            <div class="codo_already_registered">
                                {_t("Already registered?")} <a  class="codo_login_register_link" href="{$smarty.const.RURI}user/login">{_t("Login here")}</a>
                            </div>
                        </div>
                    </div>

                </form>
                {"block_register_form_end"|load_block}

            </div>
            {"block_register_form_after"|load_block}

        </div>
    </div>

    <script type="text/javascript">

        codo_defs.register = {
            pass_min: parseInt('{$min_pass_len}'),
            username_min: parseInt('{$min_username_len}')
        };

        CODOFVAR = {
            trans: {
                username_short: '{_t("username cannot be less than ")}' + codo_defs.register.username_min + '{_t(" characters")}',
                username_exists: '{_t("username already exists")}',
                password_short: '{_t("password cannot be less than ")}' + codo_defs.register.pass_min + '{_t(" characters")}',
                mail_exists: '{_t("mail already exists")}'

            }
        }

    </script>

{/block}
