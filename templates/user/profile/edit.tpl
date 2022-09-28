{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
{extends file='layout.tpl'}


{*

Edit

0. Back to Profile [header]
1. Settings
2. Preferences
3. My subscriptions
4. Notifications

*}
{block name=body}


    <div class="container-fluid top-custom-container-profile">
        <div class="container">
            <div class="row">
                <div class="col-md-1">

                    <img draggable="false" class="img-rounded profile-avatar-img" src="{$user->avatar}" />
                </div>
                <div class="codo_username col-md-6 col-sm-12 codo-username-profile">
                    <h4>{$user->username}</h4>
                    <p>{$user->signature}
                    </p>
                </div>
            </div>

        </div>
    </div>
    <div class="container" style="padding-top:0px">
        <ul class="nav nav-tabs" id="profile_tabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link" href="index.php?u=user/profile">{_t("Overview")}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="#edit" role="tab" data-toggle="tab">{_t("Edit Account")}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#preferences" role="tab" data-toggle="tab">{_t("Preference")}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#subscriptions" role="tab" data-toggle="tab">{_t("Subscription")}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#notifications" role="tab" data-toggle="tab">{_t("Notification")}</a>
            </li>
        </ul>


        <div class="row">

                {"block_profile_edit_before"|load_block}

             <div class="col-md-8 col-sm-12">
                 <div id="profile_edit_status" class="codo_notification" style="display: none"></div>
               <div class="tab-content">

                <div class="tab-pane fade active show" id="edit">


                    {"block_profile_edit_details_before"|load_block}

                    <div class="codo_edit_profile">

                        {"block_profile_edit_details_start"|load_block}

                        {if isset($file_upload_error)}

                            <div class="codo_notification codo_notification_error">{$file_upload_error}</div>
                        {/if}

                        {if isset($user_profile_edit) AND $user_profile_edit}
                            <div class="codo_notification codo_notification_success">{_t("user profile edits saved successfully")}</div>
                        {/if}


                        <form action="{$smarty.const.RURI}user/profile/{$user->id}/edit" method="POST" enctype="multipart/form-data" class="form-horizontal" role="form">
                        <span class="mdi mdi-checkbox-multiple-marked"></span>
                        <div class="codo_edit_profile_title">
                            <div class=""><span>{_t("Edit Profile")}</span></div>
                            <div style="float: right" class="col-xs-6">
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button type="submit" class="codo_btn codo_btn_primary">{_t("Save Changes")}</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="">

                          <div class="col-12 col-sm-6 col-md-8">


                              <div class="form-group">

                                  <label for="username"
                                         class="control-label profile-edit-label">{_t("username")}</label>
                                    <input type="text" name="username" class="codo_input codo_input_disabled" id="username"  value="{$user->username}" disabled="">
                            </div>
                            <div class="form-group">
                                <label for="display_name" class="control-label profile-edit-label">{_t("display name")}</label>
                                <input type="text" name="name" class="codo_input" id="codo_display_name" placeholder="" value="{$user->name}">
                            </div>



                            <div class="form-group">
                                <label for="display_name" class="control-label profile-edit-label-normal">{_t("signature")}</label>
                                <textarea name="signature" maxlength="{$signature_char_lim}" id="codo_signature_textarea" class="codo_input">{$user->signature}</textarea>
                                <span id="codo_countdown_signature_characters">{$signature_char_lim}</span>

                            {foreach from=$custom_fields item=field}


                                <div class="form-group" id="custom_field_{$field.id}">

                                    {if $field.title}
                                        <label class="control-label" for="{$field.title}" >{$field.title}</label>
                                    {/if}
                                <div>

                                        {if $field.type eq 'input'}
                                            <input value="{$field.def_val}" class="codo_input" type="{$field.input_type}" name="input_{$field.id}" placeholder="{_t({$field.title})}"
                                                   {if !($field.input_length eq 0)} maxlength="{$field.input_length}"{/if}
                                                   {if $field.is_mandatory}required=""{/if}/>

                                        {else}

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
                                                                   {if $field.is_mandatory}required=""
                                                                   {/if}type="checkbox"
                                                                   name="input_{$field.id}[]"/>{_t({$text})}
                                                        </label>
                                                    </div>
                                                {/foreach}

                                            {else if $field.type eq 'textarea'}

                                                <textarea {if $field.is_mandatory}required=""{/if} name="input_{$field.id}">{$field.def_val}</textarea>
                                            {/if}
                                        {/if}
                                    </div>
                                </div>
                            {/foreach}

                            <div id="codo_before_save_user_profile">
                            </div>

                            <!--<div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="codo_btn codo_btn_primary">{_t("Save edits")}</button>
                                </div>
                            </div>-->

                            <input type="hidden" name="token" value="{$CSRF_token}" />


                                </div>
                          <div class="col-6 col-md-4">

                            <div class="form-group" style="margin-left:0px;">
                                <label for="display_name" class="control-label profile-edit-label-normal">{_t("Avatar")}</label>
                                <div class="codo_avatar">

                                    <img class="codo_avatar_img" draggable="false" src="{$user->avatar}" />
                                    <input class="codo_change_avatar" id="codo_avatar_file" type="file" name="avatar" />
                                    <div style="display: none" id="codo_new_avatar_selected_name"></div>
                                    <img class="codo_right_arrow" id="codo_right_arrow" src="{$smarty.const.CURR_THEME}img/arrow-right.jpg" />
                                    <img class="codo_avatar_preview" src="" id="codo_avatar_preview"/>
                                    <div class="codo_btn codo_btn_def col-12 col-sm-6 col-md-8">{_t("Change")}</div>
                                    <div style="text-align: right;padding-top:5px;" class="col-6 col-md-4"><span class="small text-muted">100x100</span></div>
                                </div>
                            </div>
                            </form>

                          </div>


                    {"block_profile_edit_details_end"|load_block}

                    {"block_profile_edit_details_after"|load_block}

                    {if !$is_azure_ad_active}
                    <div class="codo_edit_profile" style="padding: 0">

                        {"block_profile_change_pass_start"|load_block}
                        <form class="form-horizontal" role="form">
                        <div class="codo_edit_profile_title">
                            <div class=""><span>{_t("Change password")}</span></div>

                        </div>
                        <br/>

                            <div class="form-group">
                                <div class="col-sm-12">
                                    <label for="curr_pass" class="control-label profile-edit-label">{_t("Current password")}</label>
                                    <input type="password" name="curr_pass" class="codo_input" id="curr_pass"  placeholder="{_t("Current password")}" required="">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <label for="new_pass" class="control-label profile-edit-label">{_t("New password")}</label>
                                    <input type="password" name="new_pass" class="codo_input" id="new_pass"  placeholder="{_t("New password")}" required="">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <label for="new_pass" class="control-label profile-edit-label">{_t("Confirm password")}</label>
                                    <input type="password" name="confirm_new_pass" class="codo_input" id="confirm_pass"  placeholder="{_t("Confirm password")}" required="">
                                </div>
                            </div>
                            <!--<div style="float: right"  class="col-md-6">
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button id="change_pass" type="submit" class="codo_btn codo_btn_primary">{_t("Change password")}</button>
                                        <span id="codo_pass_no_match_txt" class="codo_pass_no_match_txt">{_t("passwords do not match!")}</span>
                                    </div>
                                </div>
                            </div>-->
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <button id="change_pass" type="submit"
                                            class="codo_btn codo_btn_primary">{_t("Change password")}</button>
                                    <span id="codo_pass_no_match_txt"
                                          class="codo_pass_no_match_txt">{_t("passwords do not match!")}</span>
                                </div>
                            </div>
                        </form>
                        {"block_profile_change_pass_end"|load_block}
                    </div>
                    {/if}

                </div>
            </div>
</div>
</form>
</div>


        <div class="tab-pane fade" id="preferences">


                <div class="codo_edit_profile">

                    <div class="codo_edit_profile_title">
                        <div class=""><span>{_t("General")}</span></div>
                    </div>
                    <br/>
                    <form class="form-horizontal" id="codo_form_user_preferences">
                        <fieldset>
                    <div class="codo-preferences-container">

                        <!--<legend>{_t("General")}</legend>-->

                        <div class="form-group" style="margin-left:0px;margin-right:0px;">
                                <label for="frequency" class="profile-edit-label">{_t("Notification frequency")}</label>
                                <div class="">
                                    <select id="codo_notification_frequency" class="form-control">
                                        <option value="immediate" {match_option key='notification_frequency' value='immediate'}>{_t("Immediate")}</option>
                                        <option value="daily" {match_option key='notification_frequency' value='daily'}>{_t("Daily digest")}</option>
                                        <option value="weekly" {match_option key='notification_frequency' value='weekly'}>{_t("Weekly digest")}</option>
                                    </select>
                                </div>
                            </div>
                            {*
                            <div class="form-group">
                            <label class="control-label col-sm-4 profile-edit-label">{_t("Send emails when i am online")}</label>
                            <div class="col-sm-6">
                            <div id="codo_send_emails_when_online" class="codo_switch {match_switch key='send_emails_when_online' value='yes'}" style="margin-top: 6px">

                            <div class="codo_switch_toggle"></div>
                            <span class="codo_switch_on">{_t('Yes')}</span>
                            <span class="codo_switch_off">{_t('No')}</span>
                            </div>
                            </div>
                            </div>*}
                            <div class="row form-group">
                                <label class="col-sm-4 profile-edit-label">{_t("Show real-time notifications")}</label>
                                <div class="col-sm-6">
                                    <div id="real_time_notifications" class="codo_switch toggle_switch_container {match_switch key='real_time_notifications' value='yes'}" style="margin-top: 6px">
                                        <div class="codo_switch_toggle"></div>
                                        <span class="codo_switch_on">{_t('Yes')}</span>
                                        <span class="codo_switch_off">{_t('No')}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="row form-group">
                                <label class="col-sm-4 profile-edit-label">{_t("Show desktop notifications")}</label>
                                <div class="col-sm-6">
                                    <div id="desktop_notifications" class="codo_switch toggle_switch_container {match_switch key='desktop_notifications' value='yes'}" style="margin-top: 6px">
                                        <div class="codo_switch_toggle"></div>
                                        <span class="codo_switch_on">{_t('Yes')}</span>
                                        <span class="codo_switch_off">{_t('No')}</span>
                                    </div>
                                </div>
                            </div>
                    </div>

                            <div class="codo_edit_profile_title">
                    <div class=""><span>{_t("Notification level")}</span></div>
                    </div>

                            <div class="codo-preferences-container">
                            <!--<legend>{_t("Notification level")}</legend>-->
                            <div class="form-group">
                                <label class="control-label profile-edit-label-normal">{_t("When I create a topic")}</label>
                                <div class="col-12" style="height:120px;">
                                    {assign my_subscription_type 'notification_type_on_create_topic'|get_preference}
                                    {include file='forum/notification_level.tpl' id='1'}
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label profile-edit-label-normal">{_t("When I reply a topic")}</label>
                                <div class="col-12" style="height:120px;">
                                    {assign my_subscription_type 'notification_type_on_reply_topic'|get_preference}
                                    {include file='forum/notification_level.tpl' id='2'}
                                </div>
                            </div>

                                <br/><br/>
                            <div class="form-group">
                                <div class="col-sm-7">
                                    <button id="codo_update_preferences" type="submit" class="codo_btn codo_btn_primary">{_t("Update preferences")}</button>
                                    <span style="display: none" class="codo_load_more_bar_blue_gif"></span>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                    </div>
                </div>

            <div class="tab-pane fade" id="subscriptions">

                <div class="codo_edit_profile">
                    <fieldset>
                        <div class="codo_edit_profile_title">
                            <div class=""><span>{_t("Categories")}</span></div>
                        </div>
                        <!--<legend>{_t("Categories")}</legend>-->
                        {assign is_category 'yes'}
                        {foreach from=$categories item=cat}

                            <div class="codo_subscription col-sm-12">
                                <div class="col-sm-4">
                                    <div class="codo_subscription_img">
                                        <img draggable="false" src="{$smarty.const.DURI}{$smarty.const.CAT_IMGS}{$cat->cat_img}" />
                                    </div>

                                    <a href="{$smarty.const.RURI}topics/{$cat->cat_alias}">
                                        {$cat->cat_name}
                                    </a>
                                </div>
                                <div class="col-sm-8">
                                    {assign my_subscription_type $cat->type}
                                    {include file='forum/notification_level.tpl'  id="{'_category_'}{$cat->cid}"}
                                </div>
                            </div>
                        {/foreach}
                        <!--<div class='col-md-12' style='height: 3em'></div>
                        <legend>{_t("Topics")}</legend>-->
                        <div class="codo_edit_profile_title" style="clear:both;">
                            <div class=""><span>{_t("Topics")}</span></div>
                        </div>
                        {assign is_category 'no'}

                        {foreach from=$topics item=topic}

                            {assign var="avatar" value="{$smarty.const.DURI}{$smarty.const.PROFILE_IMG_PATH}{$topic->avatar}"}

                            {if $avatar == null}

                                {assign var="avatar" value="{$smarty.const.DURI}{$smarty.const.DEF_AVATAR}"}
                            {/if}

                            <div class="codo_subscription col-sm-12">
                                <div class="col-sm-12">
                                    <div class="codo_subscription_img">
                                        <a href="{$smarty.const.RURI}user/profile/{$topic->id}">
                                            <img draggable="false" src="{$avatar}" />
                                        </a>
                                    </div>

                                    <a href="{$smarty.const.RURI}topic/{$topic->tid}/"
                                       class="codo_subscription_a_style">{$topic->title}</a>
                                </div>
                                <div class="col-sm-9">
                                    {assign my_subscription_type $topic->type}
                                    {include file='forum/notification_level.tpl' id="{'_topic_'}{$topic->tid}"}
                                </div>
                            </div>

                        {/foreach}

                    </fieldset>
                </div>
            </div>
            <div class="tab-pane fade" id="notifications">

                <div class='codo_edit_profile'>
                    <div id='codo_all_notifications'>

                    </div>
                </div>
            </div>


    </div>
    </div>
                                <!--admin profile-->
            <div class="col-md-4 profile-user-statistics-right">

                <div class="codo_profile profile-user-statistics-right-inner" id="">

                    <div class="codo_user_statistics">
                        <div class="row mb-2">
                            <div class="col-md-6 codo_profile_left" style="margin-top: 2px">
                                <i class="icon icon-eye2" style="font-size: 22px;"></i>
                            </div>
                            <div class="col-md-6 codo_user_info_num codo_profile_right">
                                {$user->profile_views|abbrev_no}
                            </div>
                        </div>

                        <div class="row mb-2">
                            <!--<div class="codo_red_dot">

                            </div>
                            <div class="codo_user_info_label">

                                {_t("posts")}
                            </div>-->
                            <div class="col-md-6 codo_profile_left" style="margin-top: 2px">
                                <i class="icon icon-message" style="font-size: 22px;"></i>
                            </div>
                            <div class="col-md-6 codo_user_info_num codo_profile_right">
                                {$user->no_posts|abbrev_no}
                            </div>
                        </div>
                        <div class="row mb-2">
                            <!--<div class="codo_green_dot">

                            </div>
                            <div class="codo_user_info_label">

                                {_t("reputation")}
                            </div>-->
                            <div class="col-md-6 codo_profile_left" style="margin-top: 2px">
                            <i class="fa fa-star" style="font-size: 22px;color:#5a7fee;"></i>
                            </div>
                            <div class="codo_user_info_num col-md-6 codo_profile_right">
                                {$user->reputation}
                            </div>
                        </div>

                    </div>
                    <div class="codo_user_details">

                        <div style="color:#9f9f9f;"> {_t("Joined :")} <span style="float:right;color:#3e3e3e;font-weight:bold">{$user->created|get_pretty_time}</span>
                        </div>
                        <div style="color:#9f9f9f;">
                            {_t("Last login :")} <span style="float:right;color:#3e3e3e;font-weight:bold">{if $user->last_access eq 0}{_t('never')}{else}{$user->last_access|get_pretty_time}{/if}</span>
                        </div>

                    </div>

                </div>

            </div>


        </div>
    </div>


    <script type="text/javascript">

        CODOFVAR = {
            signature_char_limit: '{$signature_char_lim}',
            lim_notifications: 20,
            trans: {
                preferences: {
                    title: "{_t('Preferences')}", text: "{_t('Your preferences have been successfully saved')}"
                },
                subscriptions: {
                    title: "{_t('Subscriptions')}", text: "{_t('Subscription updated successfully')}"
                }
            }
        };

    </script>
{/block}
