{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
{extends file='layout.tpl'}

{block name=body}

    <div id="breadcrumb" class="col-md-12">

        <div class="codo_breadcrumb_list btn-breadcrumb hidden-xs">                
            {"block_breadcrumbs_before"|load_block}
            <a href="{$smarty.const.RURI}{$site_url}"><div><i class="glyphicon glyphicon-home"></i></div></a>
            <a href="#">{_t("Tag")}: {$tag}</a>
            {"block_breadcrumbs_after"|load_block}
        </div>
    </div>

    <div class="container">

        <div class="row">        
            <div class="col-md-8">

                <div class="codo_widget">
                    <div class="codo_widget-header">
                        {_t("Topics tagged with ")} <b>{{$tag}}</b>
                        <div id="codo_topic_title_pagination">
                        </div>

                    </div>

                    <div class="codo_widget-content codo_topics">
                        <div class="codo_topics_body" id="codo_topics_body">

                            <div class="codo_load_more_gif"></div>
                        </div>                        

                    </div>
                </div>
            </div>
        </div>
    </div>


    {literal}
        <script style="display: none" id="codo_template" type="text/html">

            {{#each topics}}
            <article class="clearfix">

                <div class="codo_post_statistics" style="position:absolute;top: 20px;">

                    <div title="{{../views_txt}}" id="codo_topics_no_views">
                        <div style="float:left;padding-top:2px;" style="float:left;">
                            <i class="icon icon-eye2" style="font-size:16px;"></i>
                        </div>
                        <div style="float:left;font-weight:bold;padding-left:3px;">
                            {{no_views}}
                        </div>
                    </div>            
                    <div title="{{../reply_txt}}">
                        <div style="float:left;padding-top:2px;" style="float:left;">
                            <i class="icon icon-message" style="font-size:16px;"></i>
                        </div>
                        <div style="float:left;font-weight:bold;padding-left:3px;">
                            <span>{{no_replies}}</span>
                        </div>
                    </div>
                </div>
                <!--
                <div class="codo_posts_post_moderation">


                    {{#if can_edit_topic}}
                    <div id="codo_posts_edit_{{topic_id}}" class="codo_posts_edit_post codo_post_this_is_topic">
                        <i class="icon-edit"></i> 
                    </div>
                    {{/if}}

                    {{#if can_delete_topic}}
                    <div rel='popover' id="codo_posts_trash_{{topic_id}}" class="codo_posts_trash_post codo_post_this_is_topic">
                        <div class="codo_spinner"></div>
                        <i class="icon-trash"></i>
                    </div>
                    {{/if}}
                </div>-->

                <div class='codo_badges'>    
                    {{#if new_topic}}

                    <a title="{{../../new_topic}}" href="{{../../RURI}}topic/{{topic_id}}/{{safe_title}}"><div class='codo_badge_new'>{{../../new}}</div></a>    
                    {{/if}}
                    {{#if new_replies}}

                    <a title="{{../../new_replies_txt}}" href="{{../../RURI}}topic/{{topic_id}}/{{safe_title}}/post-{{last_reply_id}}#post-{{last_reply_id}}"><div class='codo_unread_replies'>{{new_replies}}</div></a>
                    {{/if}}

                </div>



                <div class="codo_topics_topic_content">
                    <div class="codo_topics_topic_avatar">
                        <a href="{{../RURI}}user/profile/{{id}}">

                            <img draggable="false" src="{{avatar}}" />
                        </a>
                    </div>
                    <div class="codo_topics_topic_name">
                        <a href="{{../RURI}}user/profile/{{id}}"><span class="role_styled role_{{role}}">{{name}}</span></a>
                        <span>{{../posted}} {{post_created}}</span>
                    </div>
                    {{#if in_search}}
                    <div class="codo_topics_topic_title"><a href="{{../../RURI}}topic/{{topic_id}}/{{safe_title}}/post-{{post_id}}#post-{{post_id}}">{{{title}}}</a></div>
                    {{else}}
                    <div class="codo_topics_topic_title"><a href="{{../../RURI}}topic/{{topic_id}}/{{safe_title}}">{{{title}}}</a></div>
                    {{/if}}    

                </div>
                <div class="codo_topics_topic_message">
                    {{{message}}}

                </div>


                <div class="codo_topics_topic_foot clearfix">
                    {{#if tags}}
                    <div class="codo_readmore_container">
                        <div class="codo_tag_list">
                            <div class="codo_tags_all">

                                {{#each tags}}
                                <a class="codo_tag_a_style" title="{{../../../find_topics_tagged}} '{{tag}}'" href="{{../../../RURI}}tags/{{tag}}" title="">{{tag}}</a>
                                {{/each}}
                            </div>
                        </div>
                    </div>
                    {{/if}}

                    {{#if last_post_time}}
                    <div class="codo_topics_last_post">
                        {{../../recent_txt}} <a href="{{../../RURI}}user/profile/{{last_post_uid}}">{{last_post_name}}</a>
                        &nbsp;&middot;&nbsp; <span class='codo_topics_last_post_time'>{{last_post_time}}</span>
                    </div>
                    {{/if}}
                </div>

            </article>
            {{/each}}
        </script>
        <script id="codo_pagination" type="text/html">

            <div class="{{constants.cls}}">


                {{#each page}}

                {{#if last}}
                ...
                {{/if}}


                {{#if active}}
                <a class="codo_topics_curr_page">{{page}}</a>
                {{else}}
                <a href="{{../../constants.url}}{{page}}&search={{../../constants.search}}">{{page}}</a>
                {{/if}}

                {{#if first}}
                ...
                {{/if}}


                {{/each}}

            </div>


        </script>
    {/literal}

    <script type="text/javascript">

                                                                                                CODOFVAR = {

                                                                                                topics: {$topics},
                                                                                                        no_more_posts: '{_t("No more topics to display!")}',
                                                                                                        num_pages: '{$num_pages}',
                                                                                                        curr_page: '{$curr_page}',
                                                                                                        url: '{$url}',
                                                                                                        tags: {$tags}
                                                                                                }

    </script>

{/block}
