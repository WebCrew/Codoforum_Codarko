<?php

require_once DEF_THEME_DIR . 'AssetLoader.php';
//$css_files and $js_files are defined in Layout.php
$assetLoader = new AssetLoader($css_files, $js_files);