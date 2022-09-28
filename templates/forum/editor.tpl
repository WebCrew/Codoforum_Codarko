{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}

{* Pending draft modal *}
<div class="modal fade" id='codo_draft_pending'>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{_t("Pending draft")}</h4>
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
            </div>
            <div class="modal-body">
                <p>{_t("Your previous draft for topic ")}<span id="codo_draft_topic_title"></span> {_t("is pending")}</p>
                <p>{_t("If you continue, ")}{_t("your previous draft will be discarded.")} </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{_t("Cancel")}</button>
                <button onclick="CODOF.autoDraft.recycle();" type="button" class="btn btn-primary">{_t("Continue")}</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


{*  Link adder modal dialog  *}
<!-- Modal -->
<div class="modal animated bounceInDown" id="codo_modal_link" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">{_t("Add link")}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <input id="codo_modal_link_url" name="element_1" type="text" class="form-control" placeholder="{_t("link url")}" required=""/>
                    <hr/>

                    <input id="codo_modal_link_text" name="element_2" type="text" class="form-control" placeholder="{_t("link text")} - {_t("optional")}"/>
                    <hr/>

                    <input id="codo_modal_link_title" name="element_3" type="text" class="form-control" placeholder="{_t("link title")} - {_t("optional")}"/>
                </form>

            </div>
            <div class="modal-footer">
                <div class="codo_modal_link_cancel codo_btn codo_btn_def" data-dismiss="modal">{_t("Cancel")}</div>
                <div id="codo_modal_link_submit" class="codo_btn codo_btn_primary">{_t("Add")}</div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



{* Upload modal dialog *}
<div class="modal animated bounceInDown" id="codo_modal_upload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">{_t("Upload")}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <form class="dropzone"
                      id="codomyawesomedropzone">

                    <div class="fallback">
                        <input name="file" type="file" multiple />
                    </div>

                    <input name="token" type="hidden" value="{$CSRF_token}" />
                </form>

            </div>
            <div class="modal-footer">
                <div class="codo_modal_upload_cancel codo_btn codo_btn_def" data-dismiss="modal">{_t("Cancel")}</div>
                <div id="codo_modal_upload_submit" class="codo_btn">{_t("Upload")}</div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<a id="jquery-oembed-me"></a>
