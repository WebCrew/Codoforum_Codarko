{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
<div class="codo_notification_block">

    <div class="codo_notification_block_type">{_t("Notification level")}</div>
    <div class="codo_notification_block_slider">
        <input type="text" id="codo_notification_selector{if isset($id)}{$id}{/if}" class="codo_notification_selector col-md-12 col-xs-12" value=""
               data-slider-min="1" data-slider-handle="square"
               data-slider-max="4" data-slider-step="1" data-slider-value="{$my_subscription_type}" 
               data-slider-orientation="horizontal" data-slider-selection="before" 
               data-slider-tooltip="hide"
               
               {if isset($is_category)}
                   
                   data-iscategory="{$is_category}" 
                   
                   {if $is_category eq 'no'}
                       data-cid='{$topic->cid}'
                       data-tid='{$topic->tid}'
                   
                   {else}
                       data-cid='{$cat->cid}'
                       data-tid='{$cat->tid}'
                                              
                   {/if}   
                       
               {/if}
               
               >
    </div>

    <div class="codo_notification_block_desc">
        <span id="codo_notification_block_text{if isset($id)}{$id}{/if}"></span>
        <span class="codo_notification_block_muted hide">
            <ul>
                <li>
                    {_t("No notifications")}
                </li>
            </ul>
        </span>
        <span class="codo_notification_block_default hide">
            <ul>
                <li>
                    <b>{_t("Only")}</b>{_t(" mentions.")}
                </li>
            </ul>
        </span>
        <span class="codo_notification_block_following hide">
            <ul>
                <li>
                    {_t("New replies/topics/mentions")}        
                </li>
                <li>
                    {_t("unread count next to topic")}
                </li>
            </ul>
        </span>
        <span class="codo_notification_block_notified hide">
            <ul>
                <li>
                    {_t("New replies/topics/mentions")}        
                </li>
                <li>
                    {_t("Unread count next to topic")}
                </li>
                <li>
                    {_t("Email notifications")}
                </li>
            </ul>
        </span>

    </div>

</div>
