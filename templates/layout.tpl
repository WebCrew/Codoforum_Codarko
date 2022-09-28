{* @CODOLICENSE *}
{* Smarty *}
<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="generator" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
        <meta name="description" content="{"site_description"|get_opt}">

        {if isset($meta_author)}
        <meta name="author" content="{$meta_author}">
        {/if}
        <title>{block "title"}{$sub_title} | {$site_title}{/block}</title>
        <!--[if lte IE 8]>
         <script src="//cdnjs.cloudflare.com/ajax/libs/json2/20121008/json2.min.js"></script>
        <![endif]-->

        {"block_head"|load_block}

        <!--
                <script type="text/javascript" language="javascipt" src="http://localhost/codoforum/freichat/client/main.php"></script>
                <link rel="stylesheet" href="http://localhost/codoforum/freichat/client/jquery/freichat_themes/freichatcss.php" type="text/css">
        -->
        <script type="text/javascript">

            var on_codo_loaded = function () {
            };
            var codo_defs = {
                url: "{$smarty.const.RURI}",
                duri: "{$smarty.const.DURI}",
                def_theme: "{$smarty.const.DEF_THEME_PATH}",
                reluri: "{$smarty.const.DATA_REL_PATH}",
                token: "{$CSRF_token}",
                smiley_path: "{$smarty.const.SMILEY_PATH}",
                badges_path: "{$smarty.const.BADGES_PATH}",
                logged_in: "{($I->loggedIn()) ? 'yes' : 'no'}",
                uid: "{$I->id}",
                login_url: "{$login_url}",
                time: "{$php_time_now}",
                forum_tags_num: {$forum_tags_num},
                forum_tags_len: {$forum_tags_len},
                unread_notifications: '{$unread_notifications}',
                roleName: `{$roleName}`,
                trans: {

                    {foreach from=$translations item=translation key=key}
                    "{$key}": "{$translation}",
                    {/foreach}
                    embed_no_preview: "{_t('preview not available inside editor')}",
                    spoiler: "{_t('Spoiler')}",
                    editor: {
                        bold: "{_t('Bold')}",
                        italic: "{_t('Italic')}",
                        bulleted_list: "{_t('Bulleted List')}",
                        numeric_list: "{_t('Numeric List')}",
                        picture: "{_t('Picture')}",
                        link: "{_t('Link')}",
                        quotes: "{_t('Quotes')}",
                        preview: "{_t('Preview')}",
                        download_file: "{_t('Click to download file')}",
                        clickToViewFull: "{_t('Click to view full size image')}"
                    },
                    notify: {
                        mention: "{_t("New mention")}",
                        mention_action: "{_t("mentioned you in")}",
                        rolled_up_trans: "{_t(" for same topic")}",
                        caught_up: "{_t("No new notifications")}"
                    }
                },
                settings: {
                    hide_msg_switch: `{$hide_msg_switch}`,
                    infinite_scroll_switch: `{$infinite_scroll_switch}`
                },
                preferences: {
                    drafts: {
                        autosave: 'yes'
                    },
                    notify: {
                        real_time: "{"real_time_notifications"|get_preference}",
                        desktop: "{"desktop_notifications"|get_preference}"
                    }
                }

            };

            if (codo_defs.unread_notifications != '') {
                codo_defs.unread_notifications = parseInt(codo_defs.unread_notifications);
            } else {
                codo_defs.unread_notifications = 0;
            }

            var CODOF = {
                hook: {
                    hooks: [],
                    add: function (myhook, func, weight, args) {

                        var i = 0;
                        if (typeof weight === "undefined") {

                            weight = 0;
                        }
                        if (typeof args === "undefined") {

                            args = {
                            };
                        }

                        if (typeof CODOF.hook.hooks[myhook] !== "undefined") {

                            i = CODOF.hook.hooks[myhook].length;
                        } else {

                            CODOF.hook.hooks[myhook] = [];
                        }

                        CODOF.hook.hooks[myhook][i] = {
                            func: func,
                            args: args,
                            weight: weight
                        };
                    }
                }
            }


        </script>

        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro" rel="stylesheet">
        <link rel="shortcut icon" type="image/x-icon" href="{$smarty.const.DURI}assets/img/general/img/favicon.ico?v=1">
        <link rel="apple-touch-icon" sizes="57x57" href="https://codoforum.com/img/apple-touch-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="114x114" href="https://codoforum.com/img/apple-touch-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="72x72" href="https://codoforum.com/img/apple-touch-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="144x144" href="https://codoforum.com/img/apple-touch-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="60x60" href="https://codoforum.com/img/apple-touch-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="120x120" href="https://codoforum.com/img/apple-touch-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="76x76" href="https://codoforum.com/img/apple-touch-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="152x152" href="https://codoforum.com/img/apple-touch-icon-152x152.png">
        <link rel="icon" type="image/png" href="https://codoforum.com/img/favicon-196x196.png" sizes="196x196">
        <link rel="icon" type="image/png" href="https://codoforum.com/img/favicon-160x160.png" sizes="160x160">
        <link rel="icon" type="image/png" href="https://codoforum.com/img/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="https://codoforum.com/img/favicon-16x16.png" sizes="16x16">
        <link rel="icon" type="image/png" href="https://codoforum.com/img/favicon-32x32.png" sizes="32x32">


        <!-- Some SEO stuff -->

        {if isset($meta_robots)}

            <meta name="robots" content="{$meta_robots}">
        {/if}

        {if isset($canonical)}

            <link rel="canonical" href="{$canonical}" />
        {/if}
        {if isset($rel_prev)}

            <link rel="prev" href="{$rel_prev}" />
        {/if}
        {if isset($rel_next)}

            <link rel="next" href="{$rel_next}" />
        {/if}

        {if isset($google_plus_profile)}
            <link rel="author" href="https://plus.google.com/{$google_plus_profile}"/>
        {/if}

        {if isset($og)}    <!-- Twitter Card data -->
            <meta name="twitter:card" content="summary">

            <!-- Open Graph data -->
            <meta property="og:title" content="{$og.title}" />
            <meta property="og:type" content="{$og.type}" />
            {if isset($og.url)}<meta property="og:url" content="{$og.url}" />{/if}

            {if isset($og.image)}
                <meta property="og:image" content="{$og.image}" />{/if}
            {if isset($og.desc)}<meta property="og:description" content="{$og.desc}" />{/if}

            <meta property="og:site_name" content="{$site_title}" />

            <!-- Schema.org markup for Google+ -->
            <meta itemprop="name" content="{$og.title}">
            {if isset($og.desc)}<meta itemprop="description" content="{$og.desc}">{/if}

            {if isset($og.image)}<meta itemprop="image" content="{$og.image}">{/if}
        {/if}

        {if isset($article_published)}<meta property="article:published_time" content="{$article_published}" />{/if}

        {if isset($article_modified)}<meta property="article:modified_time" content="{$article_modified}" />{/if}

        <!-- SEO stuff ends -->


        {$page.head.css}
        {$page.head.js}

        <style type="text/css">

            .navbar {

                border-radius: 0;

            }

            .navbar-toggler {
                padding: 3px 7px;
            }

            .mm-list > li > a{
                color: #dcdcdc !important;
            }

            .nav .open > a, .nav .open > a:hover, .nav .open > a:focus {

                background: white;
            }

            .navbar-clean .container-fluid {

                padding-left: 20px;
                padding-right: 30px;
            }


            .codo_forum_title:hover {
                -webkit-transition: all 0.5s ease;
                -moz-transition: all 0.5s ease;
                -o-transition: all 0.5s ease;
                transition: all 0.5s ease;
            }

            .dropdown-menu > li > a:hover, .dropdown-menu > li > a:focus {

                color: white;
                background: #3794db;
            }

            .container{
                /* margin-top: 60px;*/
            }

            .CODOFORUM{

                position:relative !important;
                top:0;

            }

            .mm-page {

                height: 100%;
            }

            {$roleStyles}
        </style>

    </head>

    <body>

        {"block_body_start"|load_block}


        <div class="CODOFORUM">


            <nav id="mmenu" style="display: none">
                <ul>


                    {if $I->loggedIn()}
                        <li style="text-align:center">
                            <a href="{$profile_url}"><img  src="{$I->avatar}" style="width: 50px;border-radius: 30px;border: 3px solid"/></a>
                            <span style="padding: 10px 0px;font-weight:bold">{$I->name}</span>
                        </li>
                        {"block_next_to_user"|load_block}
                    {/if}

                    {"block_main_menu_start"|load_block}

                    {if $I->loggedIn()}
                        <li title="{_t('Notifications')}"
                            class="codo_inline_notifications_show_all codo_mobile_menu_notifications">

                            <a><i class="fa fa-bell"></i>
                                <span>{_t('Notifications')}</span>
                                {if $unread_notifications}
                                    <span class="codo_inline_notifications_unread_no codo_inline_notifications_unread_no_mobile">{$unread_notifications}</span>
                                {/if}

                            </a>

                        </li>

                        {if $canCreateTopicInAtleastOneCategory}
                            <li class="" onclick="codo_create_topic()">
                                <a><i class="fa fa-pencil"></i><span>{_t('New topic')}</span></a>
                            </li>
                        {/if}

                        {if $tpl eq "forum/topic" and $can_reply}
                            <li class="" onclick="CODOF.replyTopic()">
                                <a><i class="fa fa-edit"></i><span>{_t('New reply')}</span></a>
                            </li>
                        {/if}


                        <li class="">

                            <span><i class="fa fa-user"></i>{_t('Profile')}</span>
                            <ul>


                                <li><a href="{$profile_url}"><i class="fa fa-user"></i>
                                        <span>{_t("View Profile")}</span></a></li>
                                <li><a href="{$profile_url}/{$I->id}/edit"><i class="fa fa-pencil"></i>
                                        <span>{_t("Edit")}</span></a></li>
                                <li><a href="{$logout_url}"><i
                                                class="fa fa-logout"></i><span>{_t("Logout")}</span></a>
                                </li>

                            </ul>
                        </li>

                        {*<li><a href="{$logout_url}">{_t("Logout")}</a></li>*}

                    {else}

                        <li class="active"><a href="{$register_url}">{_t("Register")}</a></li>
                        <li><a id="codo_login_link" href="{$login_url}">{_t("Login")}</a></li>
                    {/if}

                    {"block_main_menu_end"|load_block}


                </ul>
            </nav>


            <nav id="nav" class="navbar navbar-expand-lg navbar-clean navbar-light fixed-top bg-white" role="navigation">
                <div class="container-fluid" style="width:85%;">

                    <div class="navbar-header">

                        {*<a class="navbar-brand " href="{$smarty.const.RURI}{$site_url}"></a>*}
                        <button type="button" class="navbar-toggler" onclick='$("#mmenu").trigger("open.mm");'>
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        {if {"forum_header_menu"|get_opt} eq "site_title"}
                            <a style="padding-left: 28px" href="{$smarty.const.RURI}{$site_url}" class="navbar-brand codo_forum_title" >{$site_title}</a>
                        {else}
                            <a href="{$smarty.const.RURI}{$site_url}" class="navbar-brand codo_forum_title" >
                                <img src="{$smarty.const.DURI}assets/img/attachments/{"forum_logo"|get_opt}" alt="codoforum logo" class="navbar-header-img">
                            </a>
                        {/if}

                    </div>


                        {*if $canCreateTopicInAtleastOneCategory}
                        <li class="codo_topics_new_topic visible-xs-block col-xs-2 float-right">
                            <a class="codo_nav_icon" href="#" onclick="codo_create_topic()">
                                <i class="icon-new-topic"></i>
                            </a>
                        </li>
                        {/if*}



                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="codo_navbar_content">

                        <ul class="nav navbar-nav ml-auto">
                            {if isset($can_search) and $can_search}
                                <li class="dropdown d-none d-sm-block global_search">
                                   <input class="codo_global_search_input codo_global_search_head_input" type="text" placeholder="{_t('Search')}" />
                                </li>
                                <li class="dropdown d-none d-sm-block global_search">
                                    <a href="#" id="codo_global_search">
                                        <i class="fa fa-search" title="Advanced search" ></i>
                                    </a>
                                </li>
                            {/if}


                            {"block_main_menu_start"|load_block}

                            {if $I->loggedIn()}
                                <li class="nav-item dropdown d-none d-sm-block codo_tooltip" data-toggle="tooltip"
                                    data-placement="bottom" title="{_t('Notifications')}">
                                    <a data-toggle="dropdown" class="nav-link dropdown-toggle codo_nav_icon codo_inline_notifications" id="codo_inline_notifications">
                                        <!--<i class="icon-bell"></i>-->
                                        <i class="material-icons">notifications</i>
                                        {if $unread_notifications}
                                            <span class="codo_inline_notifications_unread_no">{$unread_notifications}</span>
                                        {/if}
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right codo_inline_notifications_list" id="codo_inline_notifications_list" role="menu" aria-labelledby="dLabel">

                                        <div class="codo_inline_notification_header">
                                            <div class="codo_load_more_bar_black_gif" ></div>
                                            <div class="codo_inline_notification_header_content" id="codo_inline_notification_header_content">

                                                <span>{_t("Notifications")}</span>
                                                <div>
                                                    {* <span id="codo_inline_notifications_mark_read" class="fa fa-eye" data-toggle="tooltip" data-placement="bottom" title="{_t('mark as read')}"></span>*}
                                                    <span id="codo_inline_notifications_preferences" class="glyphicon glyphicon-tasks"  data-toggle="tooltip" data-placement="bottom" title="{_t('preferences')}"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="codo_inline_notification_body" id="codo_inline_notification_body">

                                            {*For template loot at the bottom*}
                                        </div>
                                        <div class="codo_inline_notification_footer codo_inline_notifications_show_all">
                                            <span>{_t("show all")}</span><i class="glyphicon glyphicon-time"></i>
                                        </div>
                                    </div>
                                </li>

                                <li class="codo_xs_li d-block d-sm-none">
                                    <a href="{$profile_url}/{$I->id}/edit#notifications">
                                        <i class="icon-bell"></i>
                                        <span class="d-block d-sm-none"> {_t("Notifications")}</span>
                                    </a>
                                </li>

                                {"block_next_to_user"|load_block}

                                <li class="nav-item codo_menu_user dropdown">

                                    <a class="nav-link codo_menu_user_img" data-toggle="dropdown"><img  src="{$I->avatar}" />
                                        <span class="codo_user_name_span">{$I->name}</span>
                                    </a>
                                    <div class="dropdown-menu codo_menu_user_container" role="menu" aria-labelledby="dLabel">

                                       <a class="dropdown-item" href="{$profile_url}"><i class="glyphicon glyphicon-user"></i>
                                                <span>{_t("View Profile")}</span></a>
                                        <a class="dropdown-item" href="{$profile_url}/{$I->id}/edit"><i class="glyphicon glyphicon-pencil"></i>
                                                <span>{_t("Edit")}</span></a>
                                        <a class="dropdown-item" href="{$logout_url}"><i
                                                        class="glyphicon glyphicon-log-out"></i><span>{_t("Logout")}</span></a>

                                    </div>
                                </li>

                                {*<li><a href="{$logout_url}">{_t("Logout")}</a></li>*}

                            {else}

                                <li class="nav-item"><a class="nav-link" href="{$register_url}">{_t("Register")}</a></li>
                                <li class="nav-item"><a class="nav-link" id="codo_login_link" href="{$login_url}">{_t("Login")}</a></li>
                            {/if}

                            {"block_main_menu_end"|load_block}

                            <li class="codo_back_to_top"><a class="codo_back_to_top_arrow"><i class="icon-arrow-top"></i></a></li>
                        </ul>
                    </div><!-- /.navbar-collapse -->
                </div><!-- /.container-fluid -->
            </nav>


            <div class='codo_modal_bg'></div>

        {block name="body"}{/block}

        <div class="codo_footer">

            {$page.body.js}
            {"block_footer"|load_block}


            <footer class="footer">
                <div class="container" style="padding:0px;">
                    <div class="row" style="padding: 5px !important">
                        <div class="col-sm-4">&copy; {'Y'|date} {$site_title}<br>


                            <small>{_t("Powered by")} <a href="http://codoforum.com" target="_blank">Codoforum</a></small>
                        </div>

                        <div class="col-sm-4 ml-auto" style="text-align: center">


                            {"block_footer_right"|load_block}



                            <span class=''></span>

                        </div>

                    </div>
                </div>
            </footer>


            <div style="display: none" id="codo_js_php_defs">
                {"block_js_php_maps"|load_block}
            </div>
        </div>
        <div class='notifications bottom-right'></div>


    </div>


    {"block_body_end"|load_block}

    {*Handlebars template for notification list*}
    {literal}
        <script style="display: none" id="codo_inline_notifications_template" type="text/html">

            {{#each objects}}
            <a target="_blank" href="{{../url}}{{link}}" class="codo_inline_notification_el codo_notification_is_read_{{is_read}}">

                <div class="codo_inline_notification_el_img">

                    {{#isRemote actor.avatar}}
                    <img src="{{../actor.avatar}}"/>
                    {{else}}
                    <img src="{{../../duri}}assets/img/profiles/icons/{{../actor.avatar}}"/>
                    {{/isRemote}}
                </div>
                <div class="codo_inline_notification_el_body">
                    <div class="codo_inline_notification_el_head">
                        <span class="codo_inline_notification_el_title">{{title}}</span>
                        {{#if rolledX}}
                        <span data-toggle="tooltip" data-placement="bottom" title="{{../rolledX}}{{../../rolled_up_trans}}" class="codo_inline_notification_el_rolled">{{rolledX}}</span>
                        {{/if}}
                        <div class="codo_inline_notification_el_created">{{created}}</div>
                    </div>
                    <div class="codo_inline_notification_el_text">
                        <span>{{{body}}}</b></span>
                    </div>
                </div>
            </a>
            {{else}}
            <div class="codo_inline_notification_caught_up">{{../caught_up}}</div>
            {{/each}}
        </script>
    {/literal}

    <div class="codo_editor_draft">
        <div>
            <div id="codo_pending_text" class="codo_pending_text">{_t("Pending draft ...")} {_t("Click to resume editing")}</div>
            <div class="codo_delete_draft"><i class="icon-trash"></i> {_t(" Discard draft")} </div>
        </div>
    </div>

    <div id = "codo_is_xs" class="d-none d-sm-block"></div>
    <div id="codo_is_sm" class="hidden-sm"></div>

    <script type="text/javascript">
        /** Lets optimize to the MAX **/
        function downloadJSAtOnload() {
            var files = JSON.parse('{$page.defer}');
            var len = files.length;
            var i = 0;
            var element = document.createElement("script");
            element.src = files[i];
            element.async = false;
            document.body.appendChild(element);
            if (element.readyState) {  //IE
                element.onreadystatechange = function () {
                    if (element.readyState === "loaded" || element.readyState === "complete") {
                        element.onreadystatechange = null;
                        on_codo_loaded();
                        codo_load_js();
                    }
                };
            } else {  //Others
                element.onload = function () {
                    on_codo_loaded();
                    CODOF.hook.call('on_cf_loaded');
                    codo_load_js();
                };
            }

            function codo_load_js() {
                let element = null;
                for (let i = 1; i < len; i++) {
                    element = document.createElement("script");
                    element.src = files[i];
                    element.async = false;
                    document.body.appendChild(element);
                }
                if (element != null) {
                    element.onerror = element.onload = function () {
                        CODOF.hook.call('on_scripts_loaded');
                    }
                } else {
                    CODOF.hook.call('on_scripts_loaded');
                }
            }
        }

    if (window.addEventListener)
            window.addEventListener("load", downloadJSAtOnload, false);
    else if (window.attachEvent)
            window.attachEvent("onload", downloadJSAtOnload);
    else window.onload = downloadJSAtOnload;
        </script>
</body>



</html>
