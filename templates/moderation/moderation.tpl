{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
{extends file='layout.tpl'}

{block name=body}

    <style type='text/css'>

        .no_topics {
        
            padding: 20px;
            background: #fff;
        }
    </style>

    {"block_breadcrumbs_before"|load_block}
    <div id="breadcrumb" class="col-md-12">
        {"block_breadcrumbs_before"|load_block}

        <div class="codo_breadcrumb_list btn-breadcrumb hidden-xs">
            <a href="{$smarty.const.RURI}{$site_url}"><div><i class="glyphicon glyphicon-home"></i></div></a>
        </div>

        {"block_breadcrumbs_after"|load_block}                
    </div>

    <div class="container" id="codo_topics_row">


        <div class="row">

            <div class="codo_topics col-md-8 clearfix">
                <div class="codo_topics_head">

                    <div class="codo_topics_head_item {$topic_head}"><a href="{$smarty.const.RURI}moderation">{$num_topics} {_t('Topics')}</a></li></div>
                    <div class="codo_topics_head_item {$reply_head}"><a href="{$smarty.const.RURI}moderation/replies">{$num_replies} {_t('Replies')}</a></li></div>

                </div>

                <div class="codo_topics_body" id="codo_topics_body">

                    {if $present}
                        {$mod_queue}
                    {else}
                        <div class='no_topics'>
                            {_t('No topics/posts to moderate')}
                        </div>
                    {/if}
                </div>
            </div>
        </div>

        <div class="codo_moderation_multi_floatbox">

            With <span id="codo_number_selected"></span> selected <button id="codo_multi_approve" class="codo_btn codo_btn_primary">{_t("Approve")}</button>
            <button id="codo_multi_delete" class="codo_btn codo_btn_danger">{_t("Delete")}</button>
        </div>


        <script type="text/javascript">

            function on_codo_loaded() {

                var floatbox = $('.codo_moderation_multi_floatbox');
                var tab_option = '{$tab_option}';

                $('#codo_topics_body input[type=checkbox]').on('change', function () {

                    var number = $('#codo_topics_body input[type=checkbox]:checked').length;
                    $('#codo_number_selected').html(number);

                    if (parseInt(number) > 0) {

                        floatbox.show();
                    } else {
                        floatbox.hide();
                    }
                });

                $('#codo_topics_body').on('click', ".codo_btn_approve", function () {

                    var info = $(this).parent();
                    if (tab_option === 'topics') {
                        var tids = [info.data('tid')];
                    } else {
                        var tids = [info.data('pid')];
                    }

                    action('approve', tids);
                });

                $('#codo_topics_body').on('click', ".codo_btn_delete", function () {

                    var info = $(this).parent();
                    if (tab_option === 'topics') {
                        var tids = [info.data('tid')];
                    } else {
                        var tids = [info.data('pid')];
                    }

                    action('delete', tids);
                });

                $('#codo_multi_approve').on('click', function () {

                    var tids = [];
                    $('.codo_topics_body input[type=checkbox]:checked').next().each(function () {

                        if (tab_option === 'topics') {
                            tids.push($(this).data('tid'));
                        } else {
                            tids.push($(this).data('pid'));
                        }
                    });

                    action('approve', tids);
                });

                $('#codo_multi_delete').on('click', function () {

                    var tids = [];
                    $('.codo_topics_body input[type=checkbox]:checked').next().each(function () {

                        if (tab_option === 'topics') {
                            tids.push($(this).data('tid'));
                        } else {
                            tids.push($(this).data('pid'));
                        }
                    });

                    action('delete', tids);
                });

                function action(what, tids) {


                    jQuery.post(codo_defs.url + 'Ajax/moderation/' + tab_option + '/' + what, {
                        token: codo_defs.token,
                        tids: tids
                    }, function (resp) {

                        if (resp === "success") {

                            window.location.reload();
                        }
                    }
                    );

                }
            }
        </script>

    {/block}

