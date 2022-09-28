{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
{extends file='layout.tpl'}

{block name=body}

    {assign "safe_title" $title|URL_safe}
    {assign "tid" $topic_info.topic_id}
    {assign "cid" $topic_info.cat_id}

    <div class="container-fluid top-custom-container-profile">
        <div class="container">
            <div class="row">

                <div class="col-md-9" style="padding-left: 0">
                    <div id="breadcrumb" class="col-md-12">


                        {"block_breadcrumbs_before"|load_block}

                        <div class="codo_breadcrumb_list btn-breadcrumb d-none d-sm-block">
                            <a href="{$smarty.const.RURI}{$site_url}"><div><i class="fa fa-home"></i></div></a>

                            {foreach from=$parents item=crumb}
                                <a title="{$crumb.name}" data-placement="bottom" data-toggle="tooltip"
                                   href="{$smarty.const.RURI}category/{$crumb.alias}">
                                    <div>{$crumb.name}</div>
                                </a>
                            {/foreach}
                            &nbsp;
                        </div>


                        <select id="codo_breadcrumb_select" class="form-control d-block d-sm-none">
                            <option selected="selected" value="">{_t("Where am I ?")}</option>
                            {assign space "&nbsp;&nbsp;&nbsp;"}
                            {assign indent "{$space}"}

                            <option value="{$smarty.const.RURI}{$site_url}">{$indent}{$home_title}</option>

                            {foreach from=$parents item=crumb}
                                {assign indent "{$indent}{$space}"}
                                <option value="{$smarty.const.RURI}category/{$crumb.alias}">{$indent}{$crumb.name}</option>
                            {/foreach}

                        </select>
                        {"block_breadcrumbs_after"|load_block}
                    </div>

                    <div class="codo_topic_blockquote">{$topic_info.cat_name}</div>
                    <div class="codo_topic_top_title">{$title|unescape}</div>

                    {if $tags}
                        <div class="codo_statistic_block_topic">
                            {foreach from=$tags item=tag}
                                <a href="{$smarty.const.RURI}tags/{$tag}">{$tag}</a>
                            {/foreach}
                        </div>
                    {/if}

                </div>
            </div>
        </div>
    </div>

    <div class="container codo_top_reply_topic_btn">
        <div class="row">
            <div class="codo_icon_header col-md-3 d-none d-sm-block d-lg-none d-block d-sm-none codo_reply_btn_container" style="padding: 0">
                {if $can_reply}
                    <button type="submit" class="codo_btn codo_btn_primary codo_can_reply codo_reply_btn"
                    >{_t("Reply")}</button>
                {/if}
            </div>
        </div>
    </div>

    <!--<div id="breadcrumb" class="col-md-12">


    {"block_breadcrumbs_before"|load_block}

    <div class="codo_breadcrumb_list btn-breadcrumb d-none d-sm-block">
        <a href="{$smarty.const.RURI}{$site_url}"><div><i class="glyphicon glyphicon-home"></i></div></a>

    {foreach from=$parents item=crumb}
        <a title="{$crumb.name}" data-placement="bottom" data-toggle="tooltip" href="{$smarty.const.RURI}category/{$crumb.alias}"><div>{$crumb.name}</div></a>
    {/foreach}
&nbsp;
</div>


<select id="codo_breadcrumb_select" class="form-control d-block d-sm-none">
<option selected="selected" value="">{_t("Where am I ?")}</option>
    {assign space "&nbsp;&nbsp;&nbsp;"}
    {assign indent "{$space}"}

    <option value="{$smarty.const.RURI}{$site_url}">{$indent}{$home_title}</option>

    {foreach from=$parents item=crumb}
        {assign indent "{$indent}{$space}"}
        <option value="{$smarty.const.RURI}category/{$crumb.alias}">{$indent}{$crumb.name}</option>
    {/foreach}

</select>
    {"block_breadcrumbs_after"|load_block}
</div>-->
    <div class="container" style="padding:0px;">
        {if $topic_is_spam}
            <div class="codo_spam_alert alert alert-warning"><b>{_t('NOTE: ')}</b>{_t('This topic is marked as spam and is hidden from public view.')}</div>
                {/if}

        <div class="row">

            <div class="codo_posts col-md-9">

                {"block_posts_before"|load_block}
                <div class="codo_widget">
                    <!--<div class="codo_widget-header" id="codo_head_title">
                        <div class="row">
                            <div class="codo_topic_title">
                                <a href="{$smarty.const.RURI}topic/{$tid}/{$safe_title}">
                                    <h1><div class="codo_widget_header_title">{$title|unescape}</div></h1>
                                </a>
                            </div>
                            <div id="codo_topic_title_pagination" class="codo_head_navigation">
                    {$pagination}
                </div>
            </div>
        </div>-->


                    <div style="display: none" id="codo_no_topics_display" class="codo_no_topics">{_t("No posts to display")}</div>

                    <div id="codo_posts_container" class="codo_widget-content">

                        {if $poll and $poll['isActive'] eq 1}
                            <article class="clearfix poll_container" id="poll_{$poll['id']}">
                                {if $poll['hasVoted'] or $poll['viewWithoutVote']}
                                    <div class="poll_result" style="display: {if $poll['hasVoted']}block{else}none{/if}">
                                        <div class="poll_title"><b>{_t("Poll Result: ")}</b>{$poll['title']}</div>
                                        <div class="poll_options">
                                            {foreach from=$poll['options'] item=option}
                                                <div class="poll_option">
                                                    <div class="poll_option_label">
                                                        <div class="poll_option_name">{$option['option_name']}</div>
                                                        <span class="poll_option_count">{$option['num_votes']|abbrev_no}&nbsp;{_t("votes")}</span>
                                                    </div>
                                                    <div class="poll_option_bar">
                                                        <div class="poll_option_fill" style="width:{$option['percent']}%">{$option['percent']}%</div>
                                                    </div>
                                                </div>
                                            {/foreach}
                                        </div>

                                        {if $poll['canRecast']}
                                            <div class="poll_footer">
                                                <div class="codo_btn" id="codo_poll_revote_btn">{_t("Cast Vote")}</div>
                                            </div>
                                        {/if}
                                    </div>
                                {/if}
                                <div class="poll_vote" style="display: {if not $poll['hasVoted']}block{else}none{/if}">
                                    <div class="poll_left_section">
                                        <i class="poll_icon glyphicon glyphicon-question-sign"></i>
                                    </div>
                                    <div class="poll_right_section col-md-10 col-12">
                                        <div class="poll_title"><b>{_t("Poll: ")}</b>{$poll['title']}</div>

                                        <div class="poll_options">
                                            {foreach from=$poll['options'] item=option}
                                                <div id="poll_option_{$option['id']}" title="{_t("Click to select this option")}" class="poll_option">{$option['option_name']}</div>
                                            {/foreach}
                                        </div>
                                        <div class="poll_footer">
                                            <div class="codo_btn" id="codo_poll_vote_btn">{_t("Vote")}</div>
                                            {if $poll['viewWithoutVote']}
                                                <div id="codo_poll_view_result_btn" class="codo_btn codo_btn_approve">{_t("View result")}</div>
                                            {/if}
                                            <img id="codo_vote_loading" src="{$smarty.const.CURR_THEME}img/ajax-loader.gif" />
                                        </div>

                                    </div>

                                </div>
                            </article>
                        {/if}

                        {$posts}
                        {if $num_pages > 1}
                            <div class="codo_topics_pagination">

                                {$pagination}
                            </div>
                        {/if}

                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="codo_topic" id="codo_topic_sidebar">
                    {"block_topic_info_before"|load_block}

                    <div class="codo_topic_statistics codo_sidebar_fixed_els row">

                        <div class="codo_cat_num col-3">
                            <i class="icon icon-eye2" style="font-size:20px;padding-top: 2px; margin-right: 10px;"></i>
                            <div class="codo_topic_views" data-number="{$topic_info.no_views}">
                                {$topic_info.no_views|abbrev_no}
                            </div>

                        </div>
                        <div class="codo_cat_num col-4" style="margin-left: 8px;">
                            <i class="icon icon-message"
                               style="font-size:20px;padding-top: 2px; margin-right: 10px;"></i>
                            <div>
                                {$topic_info.no_replies|abbrev_no}
                            </div>

                        </div>
                        <div class="codo_cat_num col-4">
                            <i class="fa fa-signal" style="font-size:20px;color:#5a7fee;margin-right: 10px;"></i>
                            <div>
                                {$no_followers|abbrev_no}
                            </div>

                        </div>

                    </div>

                    <!--{if $can_search}
                        <div class="codo_sidebar_search">
                            <input type="text" placeholder="{_t('Search')}" class="form-control codo_topics_search_input" />
                            <i class="glyphicon glyphicon-search codo_topics_search_icon" title="Advanced search" ></i>
                        </div>
                    {/if}-->


                        <!--{if $tags}
                            <div class="codo_statistic_block">
                                <ul class="codo_tags">

                        {foreach from=$tags item=tag}
                            <li ><a href="{$smarty.const.RURI}tags/{$tag}">{$tag}</a></li>
                        {/foreach}
                </ul>
            </div>
                        {/if}-->
                            {if $logged_in}
                                {include file='forum/notification_level.tpl'}
                            {/if}

                            <div class="codo_sidebar_fixed">

                                {if $can_search}
                                    <div id="codo_sidebar_fixed_search" class="codo_sidebar_search codo_sidebar_fixed_els">
                                        <input type="text" placeholder="{_t('Search')}" class="form-control codo_topics_search_input" />
                                        <i class="glyphicon glyphicon-search codo_topics_search_icon" title="Advanced search" ></i>
                                    </div>
                                {/if}

                            </div>


                            {if $is_closed}
                                <div class="codo_topic_side_div codo_topic_closed">

                                    {_t('This topic is closed')}
                                </div>
                            {/if}


                            {"block_topic_info_after"|load_block}
                        </div>

                        {if $can_reply}
                            <div style="clear:both;width:100%;" class="codo_reply_div codo_sidebar_fixed_els">
                                <button type="submit" class="codo_btn codo_reply_btn codo_can_reply codo_btn_primary"
                                        style="width:100%;padding: 14px;">{_t('Reply')}</button>
                            </div>
                        {/if}

                    </div>



                </div>
                <div id="codo_new_reply" class="codo_new_reply">

                    <div class="codo_reply_resize_handle"></div>
                    <form id="codo_new_reply_post" action="/" method="POST">

                        <div class="codo_reply_box" id="codo_reply_box">
                            <textarea placeholder="{_t('Start typing here . You can use BBcode or Markdown')}" id="codo_new_reply_textarea" name="input_text"></textarea>
                            <div class="codo_new_reply_preview" id="codo_new_reply_preview_container">
                                <div class="codo_editor_preview_placeholder">{_t("live preview")}</div>
                                <div id="codo_new_reply_preview"></div>
                            </div>
                            <div class="codo_reply_min_chars">{_t("enter atleast ")}<span id="codo_reply_min_chars_left">{$reply_min_chars}</span>{_t(" characters")}</div>

                        </div>
                        <div id="codo_non_mentionable" class="codo_non_mentionable"><b>{_t("WARNING:")} </b>{_t("You mentioned %MENTIONS%, but they cannot see this message and will not be notified")}
                        </div>

                        <div class="codo_new_reply_action">
                            <button class="codo_btn" id="codo_post_new_reply"><i class="icon-check"></i><span class="codo_action_button_txt">{_t("Post")}</span></button>
                            <button class="codo_btn codo_btn_def" id="codo_post_cancel"><i class="icon-times"></i><span class="codo_action_button_txt">{_t("Cancel")}</span></button>

                            <img id="codo_new_reply_loading" src="{$smarty.const.CURR_THEME}img/ajax-loader.gif" />
                            <button class="codo_btn codo_btn_def codo_post_preview_bg" id="codo_post_preview_btn">&nbsp;</button>
                            <button class="codo_btn codo_btn_def codo_post_preview_bg" id="codo_post_preview_btn_resp">&nbsp;</button>
                            <div class="codo_draft_status_saving">{_t("Saving...")}</div>
                            <div class="codo_draft_status_saved">{_t("Saved")}</div>

                        </div>
                        <input type="text" class="end-of-line" name="end_of_line" id="end_of_line" />
                    </form>

                </div>

                {include file='forum/editor.tpl'}
            </div>

            <div class="container codo_bottom_reply_topic_btn">
                <div class="row">
                    <div class="col-sm-12 col-md-3" style="padding: 0">
                        <div class="codo_icon_header col-lg-12 d-none d-sm-block d-lg-none d-block d-sm-none codo_reply_btn_container" style="padding: 0">
                            {if $can_reply}
                                <button type="submit" class="codo_btn codo_btn_primary codo_can_reply codo_reply_btn"
                                >{_t("Reply")}</button>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>

            <div id="codo_topics_multiselect" class="codo_topics_multiselect">

                {{_t("With")}} <span id="codo_number_selected"></span> {{_t("selected")}}

                <span class="codo_multiselect_deselect codo_btn codo_btn_sm codo_btn_def" id="codo_multiselect_deselect">{{_t("deselect posts")}}</span>
                <span style="margin-right: 4px;" class="codo_multiselect_deselect codo_btn codo_btn_sm codo_btn_def" id="codo_multiselect_show_selected">{{_t("show selected posts")}}</span>
                <select class="form-control" id="codo_topics_multiselect_select">
                    <option value="nothing">{{_t("Select action")}}</option>
                    <optgroup label="{{_t("Actions")}}">
                        <option id="move_post_option" value="move">{{_t("Move posts")}}</option>
                    </optgroup>

                </select>
            </div>


            {* Show selected posts modal *}
            <div class="modal fade" id='codo_check_show_selected_posts_modal'>
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header-info">
                            <span><b>{_t("Selected posts")}</b></span>
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        </div>
                        <div class="modal-body">

                            <b>{_t("Topic: ")}</b> <span id="codo_check_selected_posts_modal_title"></span>
                            <br/><br/>
                            <b>{_t("Selected posts: ")}</b><br/>
                            <ul id="codo_check_new_posts_modal_list"></ul>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">{_t("Close")}</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->


            {* Confirm move posts modal *}
            <div class="modal fade" id='codo_move_posts_confirm'>
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header-primary">
                            <h4 class="modal-title">{_t("Confirm move posts")}</h4>
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        </div>
                        <div class="modal-body">

                            <div style="display: none" id="codo_move_posts_confirm_moving_main_post">
                                {_t("One of the posts you selected ")}
                                {_t("is the main post of the topic, moving this post ")}<br/>
                                {_t("will make the oldest non-moved post of ")}
                                <span class="codo_move_posts_confirm_old_topic"></span> <br/>
                                {_t(" as the main topic post")}<br/>
                                <hr/>
                            </div>

                            <div style="display: none" id="codo_move_posts_confirm_deleting_old_topic">
                                {_t("You have selected all the posts from the topic, hence after moving")}<br/>
                                <span class="codo_move_posts_confirm_old_topic"></span> <br/>
                                {_t("will be deleted")}<br/>
                                <hr/>
                            </div>



                            {_t("Are you sure you want to move ")}
                            <span id="codo_move_posts_confirm_number"></span>
                            {_t(" post(s) from the topic ")}<br/>
                            <span class="codo_move_posts_confirm_old_topic"></span> <br/>
                            {_t("to the topic ")}<br/>
                            <span id="codo_move_posts_confirm_new_topic"></span>
                            {_t(" ?")}
                        </div>
                        <div class="modal-footer">
                            <div class="codo_load_more_bar_blue_gif">{_t("Moving...")}</div>
                            <button id="codo_move_posts_confirm_yes" type="button" class="btn btn-primary">{_t("Yes")}</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">{_t("No")}</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->

            {* Cannot move posts to this topic modal *}
            <div class="modal fade" id='codo_cannot_move_posts_this_topic'>
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header-warning">
                            <h4 class="modal-title">{_t("Insufficient permissions")}</h4>
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        </div>
                        <div class="modal-body">
                            {_t("You do not have permission to move posts to this category.")}
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">{_t("Close")}</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->


            {* Cannot move posts to same topic modal *}
            <div class="modal fade" id='codo_cannot_move_posts_same_topic'>
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header-warning">
                            <h4 class="modal-title">{_t("Select a different topic")}</h4>
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        </div>
                        <div class="modal-body">
                            {_t("You cannot move posts to the same topic.")}
                            <br/>
                            {_t("Please go to a different topic.")}
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">{_t("Close")}</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->

            {* Confirm check new posts modal *}
            <div class="modal fade" id='codo_check_new_posts_modal'>
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header-warning">
                            <span class="modal-title"><b>{_t("Confirm selection")}</b></span>
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        </div>
                        <div class="modal-body">

                            {_t("Are you sure you want to check this post ?")}
                            <br/>
                            {_t("If you click 'Yes', your selection for the topic ")}
                            <b><span id="codo_check_new_posts_modal_title"></span></b>
                                {_t(" will be cleared")}
                        </div>
                        <div class="modal-footer">
                            <button id="codo_check_new_posts_modal_btn_yes" type="button" class="btn btn-primary" data-dismiss="modal">{_t("Yes")}</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">{_t("No")}</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->

            {* History modal *}
            <div class="modal fade" id='codo_history_modal'>
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">{_t("Edit history")}</h4>
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        </div>
                        <div class="modal-body">

                            <div id="codo_history_table"></div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">{_t("Close")}</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->

            <div id='codo_delete_topic_confirm_html'>
                <div class='codo_posts_topic_delete'>
                    <div class='codo_content'>
                        {_t("All posts under this topic will be ")}<b>{_t("deleted")}</b> ?
                        <br/>

                        <div class="codo_consider_as_spam codo_spam_checkbox">
                            <input id="codo_spam_checkbox" name="spam" type="checkbox" checked="">
                            <label class="codo_spam_checkbox" for="spam">{_t('Mark as spam')}</label>
                        </div>
                    </div>
                    <div class="codo_modal_footer">
                        <div class="codo_btn codo_btn_def codo_modal_delete_topic_cancel">{_t("Cancel")}</div>
                        <div class="codo_btn codo_btn_primary codo_modal_delete_topic_submit">{_t("Delete")}</div>
                    </div>
                    <div class="codo_spinner"></div>
                </div>
            </div>
            <div id = "alert_placeholder"></div>

            <script>

                CODOFVAR = {
                    tid: {$tid},
                    cid: {$cid},
                    post_id: {$topic_info.post_id},
                    cat_alias: '{$topic_info.cat_alias}',
                    title: '{$safe_title}',
                    full_title: '{$title}',
                    curr_page: {$curr_page},
                    num_pages: {$num_pages},
                    num_posts: {$topic_info['no_posts']},
                    url: '{$url}',
                    new_page: '{$new_page}',
                    smileys: JSON.parse('{$forum_smileys}'),
                    reply_min_chars: parseInt({$reply_min_chars}),
                    dropzone: {
                        dictDefaultMessage: '{_t("Drop files to upload &nbsp;&nbsp;(or click)")}',
                        max_file_size: parseInt('{$max_file_size}'),
                        allowed_file_mimetypes: '{$allowed_file_mimetypes}',
                        forum_attachments_multiple: {$forum_attachments_multiple},
                        forum_attachments_parallel: parseInt('{$forum_attachments_parallel}'),
                        forum_attachments_max: parseInt('{$forum_attachments_max}')

                    },
                    trans: {
                        continue_mesg: '{_t("Continue")}'
                    },
                    deleted_msg: '{_t("The post has been ")}',
                    deleted: '{_t("deleted")}',
                    undo_msg: '{_t("undo")}',
                    search_data: '{$search_data}'
                }

                {if $poll}
                CODOFVAR.hasVoted = "{$poll['hasVoted']}";
                {else}
                CODOFVAR.hasVoted = "0";
                {/if}
            </script>

            <link rel="stylesheet" type="text/css" href="{$smarty.const.DURI}assets/markitup/highlight/styles/github.css" />
            <link rel="stylesheet" type="text/css" href="{$smarty.const.DURI}assets/dropzone/css/basic.css" />
            <link rel="stylesheet" type="text/css" href="{$smarty.const.DURI}assets/oembedget/oembed-get.css" />

            {/block}