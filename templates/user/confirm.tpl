{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
{extends file='layout.tpl'}

{block name=body}
    <div class="container">

        <div class="row">

            <div class="col-md-6">

                {if $result == "VAR_NOT_PASSED" || $result == "VAR_NOT_FOUND"}
                    <div class="codo_notification codo_notification_error">
                        {$result}{_t("There was some error. Please check your confirmation link")}
                    </div>
                {else}
                    <div class="codo_notification codo_notification_success">
                        {_t("Email confirmation successfull")}<br/>
                        {_t("You will be redirected to your ")}<a href="{$profile_url}">{_t("profile")}</a>&nbsp;{_t("in 2 seconds")}
                    </div>
                {/if}


            </div>
        </div>
    </div>

    <script type="text/javascript">

        setTimeout(function() {

            window.location.href = codo_defs.url + "user/profile";
        }, 2000);
    </script>
{/block}
