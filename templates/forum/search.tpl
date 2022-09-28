{*
/*
* @CODOLICENSE
*/
*}
{* Smarty *}
{extends file='layout.tpl'}


{block name=body}
    <div class="container">
        <span id="currPage" style="display: none">{$currPage}</span>
        <span id="selectedCids" style="display: none">{$selectedCids}</span>
        <div class="card search_header">
            <div class="card-body">
                <form id="search_form">
                    <div class="form-row">
                        <div class="form-group col-md-4 search-control">
                            <label for="search_what">{_t("What are you looking for?")}</label>
                            <input minlength="1" value="{$query}" placeholder="{_t("Enter search query...")}"
                                   type="search"
                                   class="form-control"
                                   id="search_what" required>
                            <i class="fa fa-search"></i>
                        </div>
                        <div class="form-group col-md-3">
                            <label for="search_within">{_t("Search witihin")}</label>
                            <select name="search_within" class="form-control" id="search_within">
                                <option {if {$timeWithin} eq "anytime"} selected="selected" {/if}
                                        value="anytime">{_t("Anytime")}</option>
                                <option {if {$timeWithin} eq "day"} selected="selected" {/if}
                                        value="day">{_t("Day")}</option>
                                <option {if {$timeWithin} eq "week"} selected="selected" {/if}
                                        value="week">{_t("Week")}</option>
                                <option {if {$timeWithin} eq "month"} selected="selected" {/if}
                                        value="month">{_t("Month")}</option>
                                <option {if {$timeWithin} eq "year"} selected="selected" {/if}
                                        value="year">{_t("Year")}</option>

                            </select>
                        </div>
                        <div class="form-group col-md-3">
                            <label for="match_titles">{_t("Find in")}</label>
                            <select name="match_titles" class="form-control" id="match_titles">
                                <option {if {$matchTitles} eq "yes"} selected="selected" {/if}
                                        value="yes">{_t("Titles and post content")}</option>
                                <option {if {$matchTitles} eq "no"} selected="selected" {/if}
                                        value="no">{_t("Post content")}</option>
                            </select>
                        </div>
                        <div class="form-group col-md-2">
                            <label for="search_in">&nbsp;</label>
                            <button type="submit"
                                    class="codo_btn codo_btn_primary form-control">{_t("Search")}</button>
                        </div>
                    </div>

                    <button class="col-md-1 btn btn-sm codo_btn_def" type="button" data-toggle="collapse"
                            data-target="#advanced_search"><i class="fa fa-cog"></i> {_t("More filters")}</button>

                    <div id="advanced_search" class="collapse {if $selectedCidsCount > 0}show{/if}">
                        <div class="filter_categories_label_container">
                            <label for="filter_categories">{_t("Filter categories")}</label>
                            <button type="button" id="deselect_all_categories"
                                    class="col-md-1 btn codo_btn_def btn-sm">
                                <i class="fa fa-times-circle-o"></i> {_t("Deselect all")}</button>

                        </div>

                        <select id="filter_categories" class="form-control" multiple>
                            {function name=printList}
                                {foreach $items as $item}
                                    <option value="{$item->cat_id}">{$space}{$item->cat_name}</option>
                                    {if property_exists($item, 'children')}
                                        {assign var="space" value="`$space`&nbsp;&nbsp;&nbsp;&nbsp;"}
                                        {call name=printList items=$item->children space=$space}
                                    {/if}
                                {/foreach}
                            {/function}

                            {call name=printList items=$cats space=""}
                        </select>


                        <button type="submit"
                                class="col-md-2 codo_btn codo_btn_primary form-control">{_t("Search")}</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="card info-body">
            <div class="card-body">
                <form class="form-inline">
                    <em class="{if $numRecords > 0}text-muted{else}text-danger{/if}">
                        {_t("Found %s record", "Found %s records", {$numRecords|default:'0'})}
                    </em>
                    <div class="form-items">
                        <div class="form-group form-element">
                            <label for="sort_on">Sort on</label>
                            <select name="sort_on" class="form-control mx-sm-3" id="sort_on">
                                <option {if {$sortOn} eq "post_created"} selected="selected" {/if}
                                        value="post_created">{_t("Topic/Post created time")}</option>
                                <option {if {$sortOn} eq "last_post_time"} selected="selected" {/if}
                                        value="last_post_time">{_t("Last reply time")}</option>
                                <option {if {$sortOn} eq "no_posts"} selected="selected" {/if}
                                        value="no_posts">{_t("Number of replies")}</option>
                                <option {if {$sortOn} eq "no_views"} selected="selected" {/if}
                                        value="no_views">{_t("Number of views")}</option>
                            </select>
                        </div>
                        <div class="form-group form-element">
                            <label for="order_by">Order by</label>
                            <select name="order_by" class="form-control mx-sm-3" id="order_by">
                                <option {if {$orderBy} eq "ASC"} selected="selected" {/if}
                                        value="ASC">{_t("Ascending")}</option>
                                <option {if {$orderBy} eq "DESC"} selected="selected" {/if}
                                        value="DESC">{_t("Descending")}</option>
                            </select>
                        </div>

                    </div>
                </form>
            </div>
        </div>
        {if $numRecords > $recordsPerPage}
            <div class="card pagination_body">
                <div class="card-body">
                    <div class="pagination_pages">
                        {$pagination}
                    </div>
                </div>
            </div>
        {/if}

        {if $numRecords > 0}
            <div class="card search_body">
                <div class="card-body">
                    {$topics}
                </div>
            </div>
        {/if}

        {if $numRecords > $recordsPerPage}
            <div class="card pagination_body">
                <div class="card-body">
                    <div class="pagination_pages">
                        {$pagination}
                    </div>
                </div>
            </div>
        {/if}

    </div>
{/block}