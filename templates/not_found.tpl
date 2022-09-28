{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
{extends file='layout.tpl'}

{block name=body}

    <style type="text/css">

        .codo_not_found {

            margin-top: 60px;
            background: white;
            box-shadow: 1px 1px 5px #ccc;
            padding: 20px;
        }

    </style>

    <div class="container">

        {"block_not_found_before"|load_block}        
        <div class="codo_not_found">

            {"block_not_found_start"|load_block}

            {_t("The page you are looking for does not exists!")}
            {"block_not_found_end"|load_block}

        </div>
        {"block_not_found_after"|load_block}

    </div>
{/block}
