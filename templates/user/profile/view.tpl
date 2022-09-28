{*
    /*
    * @CODOLICENSE
    */
*}
{* Smarty *}
{extends file='layout.tpl'}

{block name=body}

<div class="container-fluid top-custom-container-profile">
    <div class="container">
        <div class="row">
            <div class="col-md-1 col-sm-3">

                <img draggable="false" class="img-rounded profile-avatar-img" src="{$user->avatar}"/>
            </div>
            <div class="codo_username col-md-6 col-sm-6 codo-username-profile">
                <h4>{$user->username}</h4>
                {if $currentUser->isAdminOrModerator()}
                    <button data-toggle="modal" data-target="#codo_reward_badges" class="codo_btn codo_btn_def codo_btn_sm"><i class="fa fa-trophy"></i> Reward Badges
                    </button>
                {/if}
                <p>
                    {$user->signature}
                </p>
            </div>
        </div>
    </div>
</div>

<div class="container" style="padding-top: 0px">

    <ul class="nav nav-tabs nav-main-profile" id="profile_nav" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="overview-tab" data-toggle="tab" href="#overview"
               role="tab">{_t("Overview")}</a>
        </li>
        {if $can_edit_profile}
            <li class="nav-item">
                <a class="nav-link" id="edit-tab" data-toggle="tab" href="#edit" role="tab">{_t("Edit Account")}</a>
            </li>
        {/if}
    </ul>


    {"block_profile_view_before"|load_block}
    <div style="display:none" class="codo_notification codo_notification_error" id="codo_resend_mail_failed"></div>

    <div style="display:none" id="codo_mail_resent" class="codo_notification codo_notification_success">
        {_t("A confirmation email has been sent to your email address!")}
    </div>


    {if $user_not_confirmed}
        <div class="codo_notification codo_notification_warning">
            {_t("You have not yet confirmed your email address.")}
            <a id="codo_resend_mail" href="#">{_t("Resend email")}</a>
            <img id="codo_email_sending_img" src="{$smarty.const.CURR_THEME}img/ajax-loader-orange.gif"/>
        </div>
    {/if}
    {if $user_not_approved}
        <div class="codo_notification codo_notification_warning">
            {_t("Your account is awaiting approval.")}
        </div>
    {/if}

    <div class="row">
        <div class="col-md-8 codo_recent_posts_container">

            <div class="codo_tabs">

                <!--<ul class="nav nav-tabs">
                    <li role="presentation" class="active"><a data-toggle="tab" href="#recent_posts">Recent posts</a></li>
                </ul>-->

                <div class="codo_tabs_content tab-content">

                    <div id="recent_posts" class="tab-pane fade show active codo_topics_body">

                        {literal}
                            <div class='codo_load_more_gif'></div>
                            <script style="display: none" id="codo_template" type="text/html">


                                {{#each topics}}
                                <article class="clearfix">

                                    <!--<div class="codo_topics_topic_img">
                                        <a href="{{../RURI}}category/{{cat_alias}}">
                                            <img draggable="false" src="{{../DURI}}{{../CAT_IMGS}}{{cat_img}}" />
                                        </a>
                                    </div>-->

                                    <div class="row codo_recent_post_stats">

                                        <div class="col-md-5" style="padding-left:0px;padding-right:0px;float:right;">
                                            <div style="float:left;padding-top:2px;" style="float:left;">
                                                <i class="icon icon-message" style="font-size:16px;"></i>
                                            </div>
                                            <div style="float:left;font-weight:bold;padding-left:3px;">
                                                <span>{{no_replies}}</span>
                                            </div>
                                        </div>
                                        <div class="col-md-5" style="padding-left:0px;padding-right:0px;float:right;"
                                             id="codo_topics_no_views">
                                            <div style="float:left;padding-top:2px;" style="float:left;">
                                                <i class="icon icon-eye2" style="font-size:16px;"></i>
                                            </div>
                                            <div style="float:left;font-weight:bold;padding-left:3px;">
                                                {{no_views}}
                                            </div>
                                        </div>
                                    </div>

                                    <div class="codo_topics_topic_content">
                                        <div class="codo_topics_topic_avatar">
                                            <a href="{{../RURI}}user/profile/{{id}}">

                                                {{#if avatar}}
                                                <img draggable="false" src="{{avatar}}"/>
                                                {{else}}
                                                <img draggable="false" src="{{../../DURI}}{{../../DEF_AVATAR}}"/>
                                                {{/if}}

                                            </a>
                                        </div>

                                        <div class="codo_topics_topic_title"><a
                                                    href="{{../RURI}}topic/{{topic_id}}/{{{safe_title}}}"
                                                    style="font-size:16px;color:#000;">{{{title}}}</a></div>


                                    </div>

                                    {{#each contents}}
                                    <div class='codo_topics_topic_contents'>
                                        <div class="codo_topics_topic_message">{{{message}}}
                                        </div>
                                        <div class='codo_virtual_space'></div>
                                        <div class="codo_topics_last_post">
                                            <a href="{{../../RURI}}topic/{{../topic_id}}/{{../safe_title}}/post-{{post_id}}#post-{{post_id}}">{{post_created}}</a>
                                        </div>
                                    </div>
                                    {{/each}}

                                    <!--<div class="codo_topics_topic_name">
                                        <a href="{{../RURI}}user/profile/{{id}}"><span class="role_{{role}}">{{name}}</span></a>
                                        <span>{{../created}} {{topic_created}}</span>
                                    </div>-->

                                    <!--<div class="codo_topics_topic_foot clearfix">

                                        <div class="codo_topics_no_replies"><span>{{no_replies}}</span>{{../reply_txt}}</div>
                                        <div class="codo_topics_no_replies"><span>{{no_views}}</span>{{../views_txt}}</div>

                                    </div>-->

                                    <br/>
                                    <br/>
                                </article>
                                {{else}}

                                <div class="codo_no_posts">
                                    {{no_topics}}
                                    {{#if can_create}}
                                    <br/><br/>
                                    <button class="codo_btn codo_btn_primary" onclick="codo_create_topic()" href="#">
                                        {{new_topic}}
                                    </button>
                                    {{/if}}
                                </div>
                                {{/each}}
                            </script>
                        {/literal}
                    </div>

                    {"block_profile_view_tabs_after"|load_block}

                </div>
            </div>
        </div>


        <!--admin profile-->
        <div class="col-md-4 col-12 profile-user-statistics-right">
            <div class="codo_profile profile-user-statistics-right-inner" id="">
                {"block_profile_user_statistics_before"|load_block}
                <div class="codo_user_statistics  codo_info_block">
                    <div class="row mb-2">
                        <div class="col-md-6 codo_profile_left" style="margin-top: 2px">
                            <i class="icon icon-eye2" style="font-size: 22px;"></i>
                        </div>
                        <div class="col-md-6">
                            <div class="codo_user_info_num codo_profile_right">
                                {$user->profile_views|abbrev_no}
                            </div>
                        </div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-md-6 codo_profile_left" style="margin-top: 2px">
                            <i class="icon icon-message" style="font-size: 22px;"></i>
                        </div>
                        <div class="col-md-6 codo_user_info_num codo_profile_right">
                            {$user->no_posts|abbrev_no}
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 codo_profile_left">
                            <i class="fa fa-star" style="font-size: 22px;color:#5a7fee;"></i>
                        </div>
                        <div class="codo_user_info_num col-md-6 codo_profile_right">
                            {$user->reputation}
                        </div>
                    </div>

                </div>
                <div class="codo_user_details">

                    <div style="color:#9f9f9f;"> {_t("Joined :")} <span
                                style="float:right;color:#3e3e3e;font-weight:bold">{$user->created|get_pretty_time}</span>
                    </div>
                    <div style="color:#9f9f9f;">
                        {_t("Last login :")} <span
                                style="float:right;color:#3e3e3e;font-weight:bold">{if $user->last_access eq 0}{_t('never')}{else}{$user->last_access|get_pretty_time}{/if}</span>
                    </div>
                    {if $custom_fields != null && count($custom_fields) > 0}
                        <hr/>
                    {/if}
                    {foreach from=$custom_fields item=field}

                        <div>{$field.output}</div>
                    {/foreach}
                </div>

                <div class="codo_user_badges">

                </div>
                {"block_profile_user_statistics_after"|load_block}
            </div>
        </div>

        <!--end admin profile-->
    </div>

    {* Cannot move posts to this topic modal *}
    <div class="modal fade" id='codo_reward_badges' role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">{_t("Reward badges")}</h4>
                    <button type="button" class="close" data-dismiss="modal"><span
                                aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                </div>
                <div class="modal-body">
                    <div class="codo_badges-all-list">

                    </div>
                    <div class="text-muted"> {_t("You can add/remove badges for this user by clicking on them")}</div>
                    <div id="codo_badges_removed" class="text-muted"> {_t("Rewarded badges removed from this user: ")}<b></b></div>
                </div>
                <div class="modal-footer">
                    <div class="codo_load_more_bar_black_gif"></div>
                    <button type="button" class="btn btn-default" data-dismiss="modal">{_t("Close")}</button>
                    <button id="codo_save_badges" type="button" class="btn btn-primary">{_t("Save changes")}</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <script type="text/javascript">
        CODOFVAR = {
            userid: {$user->id},
            tab: '{$tab}'
        }
    </script>
    {/block}
