{* @CODOLICENSE *}
{* Smarty *}
{extends file='layout.tpl'}

{block name=body}
    <input type="hidden" id="page_sort_option" value="newest"/>
    <div class="container" id="codo_topics_row">

        <div class="row">

            <div class="col-lg-12 codo_mobile_top_container">

                <div class="codo_icon_header d-block d-sm-none  d-none d-sm-block d-lg-none container"
                     style="padding: 0">

                    <div onclick="CODOF.toggleTopicsAndCategories()" class="col-md-12 col-12"><i class="icon-books"
                                                                                                 title="{_t("Categories")}"></i>
                        <span id="codo_sm_categories_text">{_t("Show Categories")}</span>
                        <span id="codo_sm_topics_text" style="display: none">{_t("Show topics")}</span>
                    </div>

                    <span style="display: none"
                          id="icon-books-click-trans">{_t("Click the icon again to toggle between categories and topics")}</span>
                </div>

                {"block_catgory_list_before"|load_block}
                {if $can_search}
                    <div id="codo_mobile_top_search" class="col-sm-12">
                        <input type="text" placeholder="{_t('Search')}"
                               class="form-control codo_global_search_input"/>
                        <i class="glyphicon glyphicon-search codo_topics_search_icon"
                           title="Advanced search"></i>
                    </div>
                {/if}
            </div>
            <!--all topics -->
            <div class="codo_topics col-lg-8">
                <div class="clearfix">

                    {"block_all_topics_before"|load_block}

                    {*if $I->loggedIn() and $canCreateTopicInAtleastOneCategory*}

                    <div class="codo_topics_head d-md-block d-sm-none">

                        <div class="codo_topics_start_button_div">
                            <a class="btn btn-default btn-light codo_topics_start_button" href="#" role="button"
                               onclick="codo_create_topic()">{_t("Start New Topic")}</a>
                        </div>
                    </div>
                    {*/if*}
                    <div class="codo_topics_body" id="codo_topics_body">

                        {if $total_num_topics > 0}
                            {$topics}
                        {else}
                            <div class="codo_zero_topics">
                                {_t("No topics created yet!")}<br/><br/>
                                {_t("Be the first to")} <a
                                        href="{$smarty.const.RURI}new_topic">{_t("create")}</a> {_t("a topic")}
                            </div>
                        {/if}
                    </div>


                    <span style="display: none">
                    {*Skeleton DIV to clone in jQuery*}
                    <div id="codo_topic_page_info">
                        <span id="codo_page_info_time_spent" data-toggle="tooltip"
                              title="{_t("time spent reading previous page")}"></span>
                        <span id="codo_page_info_page_no" data-toggle="tooltip" title="{_t("page no.")}"></span>
                        <span id="codo_page_info_pages_to_go" data-toggle="tooltip"
                              title="{_t("pages to go")}"></span>
                    </div>
                </span>
                </div>
            </div>
            <!--end all topics -->
            <div class="codo_categories col-lg-4" id="codo_categories_sidebar">

                <div class="row" id="codo_category_all_topics" style="border-bottom:1px solid #eee;">

                    <div class="codo_categories_category col-md-12">
                        <!--<i class="icon-arrow-up"></i>-->
                        <div class="codo_category_title_header">{_t("Categories")}</div>
                        <!--{if isset($new_topics) && count($new_topics)}
                                <div id="codo_mark_all_read" class="codo_btn codo_mark_all_read">{_t('Mark all as read')}</div>
                            {/if}
                            <span class="codo_category_num_topics">{$total_num_topics}</span>-->
                    </div>
                </div>

                <ul id="codo_categories_ul">

                    <!--<div class="row active" id="codo_category_all_topics">
                                    <div class="codo_categories_category col-md-12">
                                            <div class="codo_category_title"></div>
                            {if isset($new_topics) && count($new_topics)}
                                    <div id="codo_mark_all_read" class="codo_btn codo_mark_all_read">{_t('Mark all as read')}</div>
                            {/if}
                            <span class="codo_category_num_topics">{$total_num_topics}</span>
                    </div>
                </div>-->

                    <li>
                        <div class="row">

                            <div class="codo_categories_category col-md-11 col-11">
                                <a href="#">
                                    <div style="padding-left: 25px"
                                         class="codo_category_title codo_category_title_active">{_t("All topics")}</div>
                                </a>
                                <span data-toggle="tooltip" data-placement="bottom" title="{_t('No. of topics')}"
                                      class="codo_category_num_topics codo_bs_tooltip">
                            {$total_num_topics}
                        </span>
                            </div>
                        </div>
                    </li>


                    {foreach from=$cats item=cat}
                        <li>
                            <div class="row">

                                <div class="codo_categories_category col-md-11 col-11">
                                    <a href="{$smarty.const.RURI}category/{$cat->cat_alias|escape:url}">
                                        <div class="codo_category_title">{$cat->cat_name}</div>
                                    </a>
                                    <span data-toggle="tooltip" data-placement="bottom"
                                          title="{_t('No. of topics')}"
                                          class="codo_category_num_topics codo_bs_tooltip">
                        {if $cat->granted eq 1}
                            {$cat->no_topics|abbrev_no}
                        {else} -
                        {/if}
                    </span>

                                    {*
                                        {if isset($new_topics) && isset($new_topics[$cat->cat_id])}
                                        <a title="{_t('new topics')}"><span class="codo_new_topics_count">{$new_topics[$cat->cat_id]|abbrev_no}</span></a>
                                        {/if}
                                        *}
                                </div>

                                {if $cat->show_children eq 0}
                                    <div class="codo_category_toggle col-md-1 col-1"><i
                                                class="icon-arrow-down"></i></div>
                                {/if}

                            </div>
                            {get_children cat=$cat new_topics=$new_topics}
                        </li>
                    {/foreach}
                </ul>
                {"block_catgory_list_after"|load_block}

                <div class="codo_sidebar_fixed">

                    {if $can_search}
                        <div id="codo_sidebar_fixed_search" class="codo_sidebar_search codo_sidebar_fixed_els">
                            <input type="text" placeholder="{_t('Search')}"
                                   class="form-control codo_topics_search_input codo_global_search_input"/>
                            <i class="glyphicon glyphicon-search codo_topics_search_icon"
                               title="Advanced search"></i>
                        </div>
                    {/if}

                    <div class="dropdown codo_sidebar_navigation codo_sidebar_fixed_els" id="codo_category_select">
                        <button value="" class="dropdown-toggle" type="button" id="dropdownMenu1"
                                data-toggle="dropdown">
                            <span>{_t("All topics")}</span>
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">

                            {foreach from=$cats item=cat}
                                <li class="dropdown-item" role="presentation"
                                    data-alias="{$cat->cat_alias}">{$cat->cat_name}</li>
                                {print_children cat=$cat}
                            {/foreach}
                        </ul>
                    </div>

                    <div class="codo_sidebar_settings">

                        <div style="border-bottom:1px solid #eee;margin:0;height:50px;">

                            <div class="codo_categories_category col-md-12">

                                <div class="codo_category_title" style="margin-top:15px;">{_t("Actions")}</div>

                            </div>
                        </div>

                        <div>
                            <div class="codo_switch">
                                <!--<div class="codo_switch_toggle"></div>-->
                                <input type="checkbox" name="group1" id="codo_sidebar_hide_msg_switch"
                                       class="chk-box codo_switch toggle_switch_container codo_switch_off">
                                <label for="codo_sidebar_hide_msg_switch"></label>
                                <!--<span class="codo_switch_on">{_t('Yes')}</span>
                                        <span class="codo_switch_off">{_t('No')}</span>-->
                            </div>
                            <span>{_t("Hide topic messages")}</span>
                        </div>

                        <div>
                            <div class="codo_switch">
                                <!--<div class="codo_switch_toggle"></div>
                                        <span class="codo_switch_on">{_t('Yes')}</span>
                                        <span class="codo_switch_off">{_t('No')}</span>-->
                                <input type="checkbox" name="group1" id="codo_sidebar_inf_scroll_switch"
                                       class="chk-box codo_switch toggle_switch_container codo_switch_on">
                                <label for="codo_sidebar_inf_scroll_switch"></label>
                            </div>
                            <span>{_t("Enable infinite scrolling")}</span>
                        </div>

                    </div>

                </div>

            </div>


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

        </div>
    </div>
    {if !$load_more_hidden}
        <div class="codo_topics_loadmore_div row" id="codo_topics_load_more">

            <div onclick="CODOF.changePage(this, {$curr_page}, 'prev')"
                 class="pagination_previous_page offset-md-1 col-md-2 col-sm-12{if $curr_page neq 1} active_page_controls{/if}">

                <i class="icon icon-arrow-left"></i>
                <div>{_t("Previous")}</div>
            </div>

            <div class="col-md-4 pagination_pages col-sm-12">
                {$pagination}
            </div>

            <div onclick="CODOF.changePage(this, {$curr_page}, 'next')"
                 class="pagination_next_page col-md-2 col-sm-12{if $curr_page neq $total_pages} active_page_controls{/if}">

                <div>{_t("Next")}</div>
                <i class="icon icon-arrow-right"></i>
            </div>

            {if $can_create_topic}
                <div class="pagination_new_topic col-md-2 col-sm-12">
                    <button id="codo_create_topic_btn" onclick="codo_create_topic()" type="submit"
                            class="codo_btn codo_btn_primary">{_t("Create new topic")}</button>
                </div>
            {/if}
            <div class="offset-md-1"></div>

        </div>
    {/if}
    <div id="codo_topics_multiselect" class="codo_topics_multiselect">

        {{_t("With")}} <span id="codo_number_selected"></span> {{_t("selected")}}
        <span class="codo_multiselect_deselect codo_btn codo_btn_sm codo_btn_def"
              id="codo_multiselect_deselect">{{_t("deselect topics")}}</span>
        <select class="form-control" id="codo_topics_multiselect_select">
            <option value="nothing">{{_t("Select action")}}</option>
            <optgroup label="{{_t("Actions")}}">
                {if $can_delete}
                    <option value="delete">{{_t("Delete topics")}}</option>
                {/if}

                {if $can_merge}
                    <option disabled value="merge">{{_t("Merge topics")}}</option>
                {/if}

                {if $can_move}
                    <option value="move">{{_t("Move topics")}}</option>
                {/if}
            </optgroup>

        </select>

    </div>
    <div class="modal fade" id='codo_multiselect_delete'>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">{_t("Delete topics")}</h4>
                    <button type="button" class="close" data-dismiss="modal"><span
                                aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                </div>
                <div class="modal-body">
                    <p>{_t("Are you sure you want to delete the following topics including its replies ?")}</p>

                    <p>
                    <div id="codo_multiselect_delete_links"></div>
                    </p>

                </div>
                <div class="modal-footer">
                    <div class="codo_loading"></div>
                    <button type="button" class="btn btn-default" data-dismiss="modal">{_t("Cancel")}</button>
                    <button onclick="multiselect.delete_topics()" type="button"
                            class="btn btn-primary">{_t("Delete")}</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    <div class="modal fade" id='codo_multiselect_merge'>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">{_t("Merge topics")}</h4>
                    <button type="button" class="close" data-dismiss="modal"><span
                                aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                </div>
                <div class="modal-body">
                    <p>{_t("Are you sure you want to merge the following topics ?")}</p>

                    <p>
                    <div id="codo_multiselect_merge_links"></div>
                    </p>

                    <p class="">{_t("Select the destination topic from above, where all topics will be merged")}</p>

                </div>
                <div class="modal-footer">
                    <div class="codo_loading"></div>
                    <button type="button" class="btn btn-default" data-dismiss="modal">{_t("Cancel")}</button>
                    <button onclick="multiselect.merge_topics()" type="button"
                            class="btn btn-primary">{_t("Merge")}</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    <div class="modal fade" id='codo_multiselect_move'>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">{_t("Move topics")}</h4>
                    <button type="button" class="close" data-dismiss="modal"><span
                                aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                </div>
                <div class="modal-body">
                    <p>{_t("The selected topics will be moved to")}</p>

                    <p>

                        <select class="form-control" id="codo_multiselect_move_category_select">
                            {foreach from=$cats item=cat}
                                <option value="{$cat->cat_id}" role="presentation">{$cat->cat_name}</option>
                                {print_children cat=$cat el=option}
                            {/foreach}

                        </select>
                    </p>


                </div>
                <div class="modal-footer">
                    <div class="codo_loading"></div>
                    <button type="button" class="btn btn-default" data-dismiss="modal">{_t("Cancel")}</button>
                    <button onclick="multiselect.move_topics()" type="button"
                            class="btn btn-primary">{_t("Move")}</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    <div class="modal fade" id='codo_report_topic'>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">{_t("Report topic")}</h4>
                    <button type="button" class="close" data-dismiss="modal"><span
                                aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                </div>
                <div class="modal-body">
                    <p>{_t("Why are you reporting this topic ?")}</p>

                    <p>

                        <select class="form-control" id="codo_report_select">
                            {foreach from=$report_types item=report}
                                <option value="{$report->id}">{$report->name}</option>
                            {/foreach}
                        </select>
                    </p>

                    <p style="display: none" id="report_reason">
                        <input id="report_details" class="form-control" type="text"
                               placeholder="{_t("provide your reason")}"/>
                    </p>


                </div>
                <div class="modal-footer">
                    <div class="codo_loading" style="right: 168px;"></div>
                    <button type="button" class="btn btn-default" data-dismiss="modal">{_t("Cancel")}</button>
                    <button onclick="CODOF.report_topic()" type="button" class="btn btn-primary">{_t("Report")}</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    <script type="text/javascript">

                    CODOFVAR = {
                        no_more_posts: '{_t("No more topics to display!")}',
                        no_posts: '{_t("No topics found matching your criteria!")}',
                        subcategory_dropdown: '{$subcategory_dropdown}',
                        num_posts_per_page: '{$num_posts_per_page}',
                        total: {$total_num_topics|default:0},
                        last_page: '{_t("last page")}'
                    };

    </script>
    <link rel="stylesheet" type="text/css" href="{$smarty.const.DURI}assets/oembedget/oembed-get.css"/>
{/block}