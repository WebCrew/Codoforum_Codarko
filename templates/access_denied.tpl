{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
{extends file='layout.tpl'}

{block name=body}

    <style type="text/css">

        .codo_access_denied {

            margin-top: 60px;
            background: white;
            box-shadow: 1px 1px 5px #ccc;
            padding: 20px;
        }
        
        body {
        
            overflow-x: hidden;
        }

    </style>

    <div class="container">

        {"block_access_denied_before"|load_block}

        <div class="codo_access_denied">

            {"block_access_denied_start"|load_block}

            {_t("You do not have enough permissions to view this page!")}

            {"block_access_denied_end"|load_block}

        </div>

        {"block_access_denied_after"|load_block}

    </div>
{/block}
