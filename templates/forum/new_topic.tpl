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
            <div  class="col-12">
                <div id="breadcrumb">

                    <div class="codo_breadcrumb_list btn-breadcrumb hidden-xs">
                        {"block_breadcrumbs_before"|load_block}
                        <a href="{$smarty.const.RURI}{$site_url}"><div><i class="fa fa-home"></i></div></a>
                        {if $selected_cat}
                            <a href="index.php?u=/category/{$selected_cat->cat_alias}">{$selected_cat->cat_name}</a>
                        {/if}
                        <!--<div>_t("New topic")}</div>-->
                        {"block_breadcrumbs_after"|load_block}
                    </div>
                </div>
            </div>

            {"block_create_topic_before"|load_block}
            <div class="col-12">
            <div class="codo_widget">

                <div class="codo_widget-header">
                    {_t("Create Topic")}
                </div>

                <div class="codo_widget-content">
                    <form id="codo_new_reply_post"  method="POST" class="" role="form">

                        <div class="form-group">
                            <label for="title">{_t("Title")}</label>
                            <div>
                                <input id="codo_topic_title" type="text" class="codo_input" value="{$topic.title}" placeholder="{_t('Give a title for your topic')}" required>
                            </div>

                        </div>

                        {if $can_add_tags}
                            <div class="form-group codo_tags">

                                <label for="tags">{_t("Tags")}</label>
                                <div>
                                    <input id="codo_tags" data-role="tagsinput" type="text" value="{$tags}" />
                                </div>
                                {*<div class="dropdown" id="codo_category_select">
                                <button value="" class="btn dropdown-toggle btn-default" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                <span>{_t("Add tag")}</span>
                                <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">

                                {foreach from=$cats item=cat}

                                <li class="dropdown-item" role="presentation"><a id="{$cat->cat_id}" data-alias="{$cat->cat_alias}">{$cat->cat_name}</a></li>
                                {/foreach}


                                </ul>
                                </div>
                                *}

                            </div>
                        {/if}

                        <div class="form-group codo_select_category">
                            <label for="category">{_t('Category')}</label>
                            <div>
                                <div class="dropdown" id="codo_category_select">
                                    <button value="" class="btn dropdown-toggle btn-default" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                        <span>{_t("Select a category")}</span>
                                        <span class="caret"></span>
                                    </button>
                                    <ul id="codo_select_category" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">

                                        {foreach from=$cats item=cat}

                                            <li class="dropdown-item" role="presentation" id="{$cat->cat_id}" data-alias="{$cat->cat_alias}">{$cat->cat_name}</li>

                                            {print_children cat=$cat}
                                        {/foreach}


                                    </ul>

                                </div>
                                <div class="codo_move_sep">
                                </div>
                                <div class="well codo_move">

                                    <span id="codo_move_text">{_t("You are moving this topic from %fromCategoryName% to %toCategoryName%")}.</span>
                                    <div class="checkbox">
                                        <label>
                                            <input id="move_notify" type="checkbox"> {_t("Notify any followers of the topic about this change ?")}
                                        </label>
                                    </div>
                                    <div class="form-group">
                                        <input id="move_reason" type="hidden" class="form-control" placeholder="{_t('reason - leave blank if not required')}" />
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div id="codo_new_reply" class="codo_new_reply">

                            <!--<div class="codo_reply_resize_handle"></div>-->

                            <div class="codo_reply_box" id="codo_reply_box">
                                <textarea placeholder="{_t('Describe your topic . You can use BBcode or Markdown')}" id="codo_new_reply_textarea" name="input_text">{$topic.imessage}</textarea>
                                <div class="codo_new_reply_preview" id="codo_new_reply_preview_container">
                                    <div class="codo_editor_preview_placeholder">{_t("live preview")}</div>
                                    <div id="codo_new_reply_preview"></div>
                                </div>
                                <div class="codo_reply_min_chars">{_t("enter atleast ")}<span id="codo_reply_min_chars_left">{$reply_min_chars}</span>{_t(" characters")}</div>
                            </div>

                            <div id="codo_non_mentionable" class="codo_non_mentionable"><b>{_t("WARNING:")} </b>{_t("You mentioned %MENTIONS%, but they cannot see this message and will not be notified")}
                            </div>

                            <div class="codo_new_reply_action">

                                <button class="codo_btn codo_new_reply_action_post" id="codo_new_reply_action_post"><i class="icon-check"></i><span class="codo_action_button_txt">{_t("Post")}</span></button>
                                <button onclick="window.history.back()" class="codo_btn codo_btn_def" id="codo_new_reply_action_cancel"><i class="icon-times"></i><span class="codo_action_button_txt">{_t("Cancel")}</span></button>

                                <img id="codo_new_reply_loading" src="{$smarty.const.CURR_THEME}img/ajax-loader.gif" />
                                <button class="codo_btn codo_btn_def codo_post_preview_bg" id="codo_post_preview_btn">&nbsp;</button>
                                <button class="codo_btn codo_btn_def codo_post_preview_bg" id="codo_post_preview_btn_resp">&nbsp;</button>
                                <div class="codo_draft_status_saving">{_t("Saving...")}</div>
                                <div class="codo_draft_status_saved">{_t("Saved")}</div>

                            </div>
                            <input type="text" class="end-of-line" name="end_of_line" />

                        </div>

                        <hr class="perm_sticky_auto_close"/>

                        <div class="form-group" id="alter_topic_status" style="display: none">
                            <label for="title">{_t('Topic should be')}</label>
                            <div>
                                <input id="topic_status_stickyfc" name="topic_status" value="stickyfc" {if $radio_topic_status eq 'stickyfc'}checked{/if} type="radio" />
                                <label for="topic_status_stickyfc">{_t('sticky and show in front page and category page')}</label>
                            </div>
                            <div>
                                <input id="topic_status_stickyc" name="topic_status" value="stickyc" {if $radio_topic_status eq 'stickyc'}checked{/if} type="radio" />
                                <label for="topic_status_stickyc">{_t('sticky and show only in category page')}</label>
                            </div>
                            <div>
                                <input id="topic_status_notsticky" name="topic_status" value="notsticky" {if $radio_topic_status eq 'notsticky'}checked{/if} type="radio" />
                                <label for="topic_status_notsticky">{_t('not sticky')}</label>
                            </div>

                            <div class="muted">{_t('sticky topics are always shown before the normal topics')}</div>
                        </div>
                        <br/>

                        <div class="form-group perm_auto_close" style="display: none">
                            <label for="title">{_t('Set the topic status as')}</label>

                            <div>
                                <div id="is_topic_open" class="codo_switch toggle_switch_container codo_switch_on">
                                    <div class="codo_switch_toggle"></div>
                                    <span class="codo_switch_on">{_t('Open')}</span>
                                    <span class="codo_switch_off">{_t('Close')}</span>
                                </div>
                            </div>
                            <div class="muted">{_t('people cannot reply to closed topics')}.</div>
                        </div>

                        <div class="form-group perm_auto_close" style="display: none">
                            <label for="title">{_t('Should the topic be auto-closed ?')}</label>

                            <div>
                                <div id="topic_auto_close" class="codo_switch toggle_switch_container codo_switch_off">
                                    <div class="codo_switch_toggle"></div>
                                    <span class="codo_switch_on">{_t('Yes')}</span>
                                    <span class="codo_switch_off">{_t('No')}</span>
                                </div>
                            </div>

                            <div id="content_toggle_topic_auto_close">
                                <b>{_t('On')}</b>
                                <div class="form-group">
                                    <div class="col-sm-6" style="padding-left: 0">
                                        <input placeholder="{_t("Select a date")}" class="form-control col-md-3" type="text" id="datetimepicker"/>
                                    </div>
                                </div>
                                <div class="muted">{_t('topic will automatically closed on mentioned date')}.</div>
                            </div>
                        </div>

                        <div class="form-group" id="add_poll_switch_container" >

                            <label for="title">{_t('Add a poll to this topic ?')}</label>
                            <div>
                                <div id="add_poll_switch" class="codo_switch toggle_switch_container codo_switch_off">
                                    <div class="codo_switch_toggle"></div>
                                    <span class="codo_switch_on">{_t('Yes')}</span>
                                    <span class="codo_switch_off">{_t('No')}</span>
                                </div>
                            </div>
                        </div>

                        <div class="form-group add_poll_container" id="add_poll_toggle_yes" style="display: none">
                            <div>
                                <div class="form-group">
                                    <label for="title">{_t("Poll question")}</label>
                                    <div>
                                        <input id="poll_question" type="text" class="codo_input" placeholder="{_t('Give a title for your poll')}">
                                    </div>
                                </div>
                                <div class="form-group" id="codo_poll_inputs">
                                    <label for="title">{_t("Poll options")}</label>
                                    <div class="codo_poll_input">
                                        <input id="poll_question" type="text" class="codo_input" placeholder="{_t('Poll option')}">
                                        <div class="codo_poll_options">
                                            <div title="{_t("add poll option")}" class="codo_poll_option codo_poll_add_option"><i class="fa fa-plus"></i></div>
                                            <div title="{_t("remove poll option")}" class="codo_poll_option codo_poll_remove_option"><i class="fa fa-minus"></i></div>
                                        </div>
                                    </div>
                                    <div class="codo_poll_input">
                                        <input id="poll_question" type="text" class="codo_input" placeholder="{_t('Poll option')}">
                                        <div class="codo_poll_options">
                                            <div title="{_t("add poll option")}" class="codo_poll_option codo_poll_add_option"><i class="fa fa-plus"></i></div>
                                            <div title="{_t("remove poll option")}" class="codo_poll_option codo_poll_remove_option"><i class="fa fa-minus"></i></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="advanced_poll_options">
                                    <div class="form-group col-md-6 col-sm-12">
                                        <label for="title">{_t('Can user recast his vote ?')}</label>

                                        <div id="can_recast_vote" class="codo_switch toggle_switch_container codo_switch_on">
                                            <div class="codo_switch_toggle"></div>
                                            <span class="codo_switch_on">{_t('Yes')}</span>
                                            <span class="codo_switch_off">{_t('No')}</span>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6 col-sm-12">
                                        <label for="title">{_t('Show poll result without voting ?')}</label>
                                        <div id="show_result_without_vote" class="codo_switch toggle_switch_container codo_switch_on">
                                            <div class="codo_switch_toggle"></div>
                                            <span class="codo_switch_on">{_t('Yes')}</span>
                                            <span class="codo_switch_off">{_t('No')}</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="title">{_t('Should the poll be auto-closed ?')}</label>

                                    <div>
                                        <div id="poll_auto_close" class="codo_switch toggle_switch_container codo_switch_off">
                                            <div class="codo_switch_toggle"></div>
                                            <span class="codo_switch_on">{_t('Yes')}</span>
                                            <span class="codo_switch_off">{_t('No')}</span>
                                        </div>
                                    </div>

                                    <div id="content_toggle_poll_auto_close" style="display: none">
                                        <b>{_t('On')}</b>
                                        <div class="form-group">
                                            <div class="col-sm-6" style="padding-left: 0">
                                                <input placeholder="{_t("Select a date")}" class="form-control col-md-3" type="text" id="polldatepicker"/>
                                            </div>
                                        </div>
                                        <div class="muted">{_t('poll will be automatically closed on mentioned date')}.</div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <hr class="perm_sticky_auto_close"/>

                        <div class="codo_new_reply_action perm_sticky_auto_close">

                            <button class="codo_btn codo_new_reply_action_post" id="trigger_codo_new_reply_action_post"><i class="icon-check"></i><span class="codo_action_button_txt">{_t("Post")}</span></button>
                            <button onclick="window.history.back()" class="codo_btn codo_btn_def" id="trigger_codo_new_reply_action_cancel"><i class="icon-times"></i><span class="codo_action_button_txt">{_t("Cancel")}</span></button>
                        </div>
                        <input type="text" class="end-of-line" id="end_of_line" name="end_of_line" />
                        <input id="codo_topic_cat" name="codo_topic_cat" type="hidden" />
                        <input id="codo_topic_cat_alias" name="codo_topic_cat_alias" type="hidden" />
                        <input type="hidden" name="token" value="{$CSRF_token}" />

                    </form>
                </div>

            </div>
        </div>
            {"block_create_topic_after"|load_block}
            <div id = "alert_placeholder"></div>
        </div>

        {include file='forum/editor.tpl'}
    </div>
    <script type="text/javascript">

        CODOFVAR = {
            smileys: JSON.parse('{$forum_smileys}'),
            reply_min_chars: parseInt({$reply_min_chars}),
            trans: {
                continue_mesg: '{_t("Continue")}'
            },
            dropzone: {
                dictDefaultMessage: '{_t("Drop files to upload &nbsp;&nbsp;(or click)")}',
                max_file_size: parseInt('{$max_file_size}'),
                allowed_file_mimetypes: '{$allowed_file_mimetypes}',
                forum_attachments_multiple: {$forum_attachments_multiple},
                forum_attachments_parallel: parseInt('{$forum_attachments_parallel}'),
                forum_attachments_max: parseInt('{$forum_attachments_max}')

            }

        };

        function add_poll_option(event, value) {

            value = value || "";

            if ($('.codo_poll_input').length === {$max_poll_options}) {

                CODOF.util.alert("{_t("Cannot add more than %s poll options", null, $max_poll_options)}", "{_t("Cannot add")}");
                return false;
            }

            var poll_option = $(event.target).parents('.codo_poll_input');
            var clone = poll_option.clone();
            clone.insertAfter(poll_option).find("input").val(value);

            return clone;
        }

        function remove_poll_option(event) {

            if ($('.codo_poll_input').length === 2) {

                CODOF.util.alert("{_t("Poll must have atleast 2 options")}", "{_t("Cannot delete")}");
                return false;
            }

            var poll_option = $(event.target).parents('.codo_poll_input');
            poll_option.slideUp().remove();
        }

        CODOF.hook.add('editor.js_init', function () {
            CODOF.editor.initMarkupEditor();
        });

        function on_codo_loaded() {

            CODOF.selectCat = function(cat_id) {

                $('#codo_category_select li').each(function () {

                    if (parseInt($(this).attr('id')) === cat_id) {

                        $('#codo_category_select > button > span:first-child').text($.trim($(this).text()));
                        $('#codo_topic_cat').val($(this).attr('id'));
                        $('#dropdownMenu1').val($(this).attr('id'));
                        $('#codo_topic_cat_alias').val($(this).data('alias'));
                        //$('#codo_category_select li  a').off();
                        $('.codo_new_reply_action_post .codo_action_button_txt').html('{_t("Save")}');
                        //$('#codo_category_select button').css('background','#eee');

                        CODOFVAR.cid = cat_id;
                    }
                });
            };


        {if $can_make_sticky}

            $('#alter_topic_status').show();
        {/if}

        {if $can_close_topics}
            $(".perm_auto_close").show();
        {/if}

        {if !$can_make_sticky && !$can_close_topics}
            $('.perm_sticky_auto_close').hide();
        {/if}

        {if $can_add_poll}
            $("#add_poll_switch_container").show();
        {/if}

        {if $selected_cat}
            CODOF.selectCat(parseInt({$selected_cat->cat_id}));
        {/if}


            CODOFVAR.pollData = '{$poll_data}';

            if (CODOFVAR.pollData !== "") {

                var pollData = JSON.parse(CODOFVAR.pollData);


                if (pollData.isActive === 1) {

                    CODOF.switch.set('add_poll_switch', true);
                    $('#add_poll_toggle_yes').show();

                    if(pollData.canRecast === 0) {

                        CODOF.switch.set('can_recast_vote', false);
                    }

                    if(pollData.viewWithoutVote === 0) {

                        CODOF.switch.set('show_result_without_vote', false);
                    }

                    $('#poll_question').val(pollData.title);

                    $('.codo_poll_input:first').remove();

                    var afterDiv = $('.codo_poll_input:first #poll_question')[0];

                    for (var i = 0; i < pollData.options.length; i++) {

                        var option = pollData.options[i];
                        var clone = add_poll_option({
                            target: afterDiv
                        }, option.option_name);

                        afterDiv = clone.find('#poll_question');
                    }

                    $('.codo_poll_input:first').remove();
                }
            }


            $('#codo_poll_inputs').on('click', '.codo_poll_add_option', add_poll_option);
            $('#codo_poll_inputs').on('click', '.codo_poll_remove_option', remove_poll_option);
            $datepicker = $('#polldatepicker').pickadate();
            CODOF.poll_datepicker = $datepicker.pickadate('picker');
            $('#poll_auto_close').on('switch_on', function () {

                $('#content_toggle_poll_auto_close').show();
            }).on('switch_off', function () {

                $('#content_toggle_poll_auto_close').hide();
            });
            $('#trigger_codo_new_reply_action_post').click(function () {

                $('#codo_new_reply_action_post').trigger('click');
            });
            CODOF.inTopic = true;
            $datepicker = $('#datetimepicker').pickadate();
            CODOF.datepicker = $datepicker.pickadate('picker');
            $('#topic_auto_close').on('switch_on', function () {

                $('#content_toggle_topic_auto_close').show();
            }).on('switch_off', function () {

                $('#content_toggle_topic_auto_close').hide();
            });
            $('#add_poll_switch').on('switch_on', function () {

                $('#add_poll_toggle_yes').show();
                {if !$can_make_sticky && !$can_close_topics}
                    $('.perm_sticky_auto_close').show();
                {/if}

            }).on('switch_off', function () {

                $('#add_poll_toggle_yes').hide();
                {if !$can_make_sticky && !$can_close_topics}
                    $('.perm_sticky_auto_close').hide();
                {/if}

            });
            setTimeout(function () {
                $('#codo_topic_title').focus();
            }, 500);
            $('html, body').animate({
                scrollTop: $(".codo_widget-header").offset().top
            }, 500);
            CODOF.editor_form = $('#codo_new_reply_post');
            CODOF.editor_preview_btn = $('#codo_post_preview_btn');
            CODOF.editor_reply_post_btn = $('.codo_new_reply_action_post');
            $('#codo_new_reply_textarea').putCursorAtEnd();
            $('#codo_category_select li').on('click', function () {
                var cid = $(this).attr('id');
                $('#codo_category_select > button > span:first-child').text($.trim($(this).text()));
                $('#codo_topic_cat').val(cid);
                $('#dropdownMenu1').val(cid);
                $('#codo_topic_cat_alias').val($(this).data('alias'));
                //return false;
                CODOFVAR.cid = cid;
                CODOF.mentions.updateSpec(cid);
                CODOF.mentions.checkForNonMentions();
                CODOF.newCatName = $('#codo_category_select > button > span:first-child').text();
                if (CODOF.oldCatName) {

                    if (CODOF.oldCatName == CODOF.newCatName) {

                        $('.codo_move, .codo_move_sep').slideUp();
                    } else {

                        $('#codo_move_from_category_name').text(CODOF.oldCatName);
                        $('#codo_move_to_category_name').text(CODOF.newCatName);
                        $('.codo_move, .codo_move_sep').slideDown()
                    }
                }

            });
            $('#codo_tags').tagsinput({
                maxTags: codo_defs.forum_tags_num,
                maxChars: codo_defs.forum_tags_len,
                trimValue: true
            });
            var str = $('#codo_non_mentionable').html();
            $('#codo_non_mentionable').html(str.replace('%MENTIONS%', '<span id="codo_nonmentionable_users"></span>'));


            CODOF.mentions.extractAndAddToManned($("#codo_new_reply_textarea").val());
            //should be called ONLY after tagsinput() init
            CODOF.restoreFromDraft = function () {

                var obj = JSON.parse(localStorage.getItem('reply_' + codo_defs.uid));
                if (obj === null)
                    return;
                if (obj.title !== "") {
                    //add title
                    $('#codo_topic_title').val(obj.title);
                }

                if (obj.tags && obj.tags.length > 0) {
                    //add tags
                    var i, len = obj.tags.length;
                    for (i = 0; i < len; i++) {

                        $('#codo_tags').tagsinput('add', obj.tags[i]);
                    }

                }

                //add message
                $("#codo_new_reply_textarea").val(obj.text);
                CODOF.mentions.extractAndAddToManned(obj.text);
                if (obj.cat) {
                    //add cat
                    CODOF.selectCat(parseInt(obj.cat));
                    CODOF.mentions.checkForNonMentions();
                }

                /*if (obj.poll_title) {

                 $('#poll_question').val(obj.poll_title);
                 }

                 if (obj.poll_options) {

                 //2 options already exists
                 for (var i = 2; i <= obj.poll_options.length; i++)
                 {
                 add_poll_option({
                 target: $('.codo_poll_input:first').find('.glyphicon-plus')
                 });
                 }

                 for(var i=0; i<obj.poll_options.length; i++) {

                 $('.codo_poll_input input').get(i).value = obj.poll_options[i];
                 }
                 }*/
            };
            if (window.location.hash === '#draft') {

                CODOF.restoreFromDraft();
            } else if (window.location.hash === '#draftEdit') {

                var y = confirm('aa');
            } else {

                if (localStorage.getItem('reply_' + codo_defs.uid) !== null) {

                    var obj = JSON.parse(localStorage.getItem('reply_' + codo_defs.uid));
                    $('#codo_draft_topic_title').text(obj.title);
                    $('#codo_draft_pending').modal();
                }
            }


            function select_curr_cat() {


                var cat_id = parseInt('{$topic.cat_id}');
                CODOF.edit_topic_id = false;
                if (cat_id !== 0) {

                    CODOF.edit_topic_id = parseInt('{$topic.topic_id}');
                    CODOF.selectCat(cat_id);
                    CODOF.oldCatName = $('#codo_category_select > button > span:first-child').text();
                    $('#codo_move_text').html(
                            $('#codo_move_text').text()
                            .replace('%fromCategoryName%', '<span id="codo_move_from_category_name"></span>')
                            .replace('%toCategoryName%', '<span id="codo_move_to_category_name"></span>')
                            );
                }

            }
            ;
            select_curr_cat();
        {if $is_topic_open}
            CODOF.switch.set('is_topic_open', true);
        {else}
            CODOF.switch.set('is_topic_open', false);
        {/if}

        {if $is_auto_close}
            $('#content_toggle_topic_auto_close').show();
            CODOF.switch.set('topic_auto_close', true);
            CODOF.datepicker.set('select', '{$auto_close_date}', {
                format: 'yyyy-mm-dd'

            });
        {/if}

            CODOF.submitted = function () {
                //$('#codo_reply_replica').val($('#codo_new_reply_preview').html());

                var warned = false;
                if (CODOF.editor_reply_post_btn.hasClass('codo_btn_primary') && !CODOF.is_error()) {

                    if (!warned) {

                        if (CODOF.mentions.warnForNonMentions()) {

                            warned = true;
                            return false;
                        }
                    }
                    CODOF.editor_reply_post_btn.removeClass('codo_btn_primary');
                    $('#codo_new_reply_loading').show();
                    var action = 'create';
                    if (CODOF.edit_topic_id) {

                        action = 'edit';
                    }

                    $('#codo_reply_box').append('<div id="codo_reply_html_playground"></div>');
                    $('#codo_reply_html_playground').html($('#codo_new_reply_preview').html());
                    $('#codo_reply_html_playground .codo_embed_container').remove();
                    $('#codo_reply_html_playground .codo_embed_placeholder').remove();
                    $('#codo_reply_html_playground .codo_oembed').each(function () {

                        var href = $(this).attr('href');
                        $(this).html(href);
                    });
                    var poll_data = {
                        "viewResultWithoutVote": CODOF.switch.get('show_result_without_vote') ? 'yes' : 'no',
                        "canRecast": CODOF.switch.get('can_recast_vote') ? 'yes' : 'no',
                        "endTime": CODOF.poll_datepicker.get(),
                        "options": $('#codo_poll_inputs input').map(function () {
                            return this.value;
                        }).get()
                    };
                    var title = $.trim($('#codo_topic_title').val());
                    CODOF.req.data = {
                        title: title,
                        cat: $.trim($('#codo_topic_cat').val()),
                        imesg: $('#codo_new_reply_textarea').val(),
                        omesg: $('#codo_reply_html_playground').html().replace(/\</g, 'STARTCODOTAG'),
                        end_of_line: $('#end_of_line').val(),
                        token: codo_defs.token,
                        tid: CODOF.edit_topic_id,
                        notify: $('#move_notify').prop('checked'),
                        reason: $('#move_notify').val(),
                        tags: $('#codo_tags').tagsinput('items'),
                        sticky: $('input[name=topic_status]:checked').val(),
                        is_open: CODOF.switch.get('is_topic_open') ? 'yes' : 'no',
                        is_auto_close: CODOF.switch.get('topic_auto_close') ? 'yes' : 'no',
                        auto_close_date: CODOF.datepicker.get(),
                        has_poll: CODOF.switch.get('add_poll_switch') ? 'yes' : 'no',
                        poll_title: $('#poll_question').val(),
                        poll_data: poll_data
                    };
                    CODOF.hook.call('before_req_send');
                    $.post(
                            codo_defs.url + 'Ajax/topic/' + action,
                            CODOF.req.data,
                            function (response) {

                                var obj;
                                try {
                                    obj = JSON.parse(response);
                                } catch (e) {
                                    obj = response;
                                }
                                if (obj.tid) {

                                    CODOF.autoDraft.remove();
                                    window.location.href = codo_defs.url + 'topic/' + obj.tid + '/' + title;
                                } else {
                                    alert(response);
                                    CODOF.editor_reply_post_btn.addClass('codo_btn_primary');
                                }

                                $('#codo_new_topic_loader').hide();
                            }

                    ).fail(function(response) {
                        var obj;
                        try {
                            obj = JSON.parse(response.responseText);
                        } catch (e) {
                            obj = response;
                        }
                        alert('Error: ' + obj.error.message);
                    });
                }

                return false;
            };
            CODOF.is_error = function () {

                var error = false;
                var val = $.trim($('#dropdownMenu1').val());
                if (val === "") {

                    $('#dropdownMenu1').addClass('boundary-error').focus();
                    error = true;
                } else {

                    $('#dropdownMenu1').removeClass('boundary-error');
                }

                if ($('#add_poll_switch').hasClass('codo_switch_on') && $('#poll_question').val() === "") {

                    CODOF.util.alert("{_t("Poll must have a question/title")}");
                    error = true;
                } else if ($('#add_poll_switch').hasClass('codo_switch_on')) {

                    var poll_option_filled = 0;
                    $('#codo_poll_inputs input').each(function () {
                        if (this.value !== "")
                            poll_option_filled++;
                    });
                    if (poll_option_filled < 2) {
                        CODOF.util.alert("{_t("Poll must have at least two options")}");
                        error = true;
                    }
                }

                $('#codo_new_reply_post :input[required=""],#codo_new_reply_post :input[required]').each(function () {

                    var val = $(this).val();
                    if ($.trim(val) === "") {

                        $(this).addClass('boundary-error').focus();
                        error = true;
                        return false;
                    } else {
                        $(this).removeClass('boundary-error')
                    }
                });
                return error;
            };
        }
        ;

    </script>

    <link rel="stylesheet" type="text/css" href="{$smarty.const.DURI}assets/markitup/highlight/styles/github.css" />
    <link rel="stylesheet" type="text/css" href="{$smarty.const.DURI}assets/dropzone/css/basic.css" />


{/block}

