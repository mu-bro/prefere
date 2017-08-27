<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="button" onclick="$('#form').submit();" form="form-banner" data-toggle="tooltip" title="<?php echo
                $button_save; ?>"
                        class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"
                   class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="form-group">
                        <div class="col-sm-5">
                    <table class="table table-striped table-bordered table-hover">
                        <tr>
                            <td><span class="required">*</span> <?php echo $entry_name; ?></td>
                            <td><input type="text" name="name" value="<?php echo $name; ?>"/>
                                <?php if ($error_name) { ?>
                                    <span class="error"><?php echo $error_name; ?></span>
                                <?php } ?></td>
                        </tr>
                        <tr>
                            <td>Number items in column:</td>
                            <td><input type="text" name="column_limit" value="<?php echo $column_limit; ?>"/></td>
                        </tr>
                        <tr>
                            <td>Special id:</td>
                            <td><input type="text" name="style_id" value="<?php echo $style_id; ?>"/></td>
                        </tr>
                        <tr>
                            <td>Color:</td>
                            <td><input type="text" name="color" value="<?php echo $color; ?>"/></td>
                        </tr>
                        <tr>
                            <td>Column width (px) :</td>
                            <td><input type="text" name="column_width" value="<?php echo $column_width; ?>"/></td>
                        </tr>
                    </table>
                            </div>
                        </div>
                    <br/>
                    <table id="route" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <td class="left" style="display:none;"><?php echo $entry_store; ?></td>
                            <td class="left">Item icon:</td>
                            <td class="left"><?php echo $entry_type; ?></td>
                            <td class="left"><?php echo $entry_route; ?></td>
                            <td class="left"><?php echo $entry_sort_order; ?>
                                <hr/><?php echo $entry_route_name; ?></td>
                            <td></td>
                        </tr>
                        </thead>
                        <?php $route_row = 0; ?>
                        <?php foreach ($menu_routes as $menu_route) { ?>
                        <tbody id="route-row<?php echo $route_row; ?>">
                        <tr>
                            <td class="left" style="display:none;"><select name="menu_route[<?php echo $route_row; ?>][store_id]">
                                    <option value="0"><?php echo $text_default; ?></option>
                                    <?php foreach ($stores as $store) { ?>
                                        <?php if ($store['store_id'] == $menu_route['store_id']) { ?>
                                            <option value="<?php echo $store['store_id']; ?>"
                                                    selected="selected"><?php echo $store['name']; ?></option>
                                        <?php } else { ?>
                                            <option
                                                value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select></td>
                            <td class="left">
                                <div class="image">

                                    <a href="" id="thumb-image<?php echo $route_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $menu_route['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>

                                    <input type="hidden" name="menu_route[<?php echo $route_row; ?>][image]"
                                           value="<?php echo $menu_route['image']; ?>" id="input-image<?php echo $route_row; ?>"/>
                                </div>
                            </td>
                            <td class="left"><select name="menu_route[<?php echo $route_row; ?>][menu_type]"
                                                     onchange="changeTypeMenu('<?php echo $route_row; ?>');">
                                    <?php foreach ($types as $type => $name) { ?>
                                        <?php if ($type == $menu_route['menu_type']) { ?>
                                            <option value="<?php echo $type; ?>" selected="selected"><?php echo $name; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $type; ?>"><?php echo $name; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                                <br/>
                                <select
                                    id="menu_route_2_<?php echo $route_row; ?>" <?php if ("submenu" != $menu_route['menu_type']) { ?> style="display:none;" <?php } ?>
                                    name="menu_route[<?php echo $route_row; ?>][menu_type_2]"
                                    onchange="changeTypeMenu2('<?php echo $route_row; ?>');">
                                    <?php foreach ($types2 as $type => $name) { ?>
                                        <?php if ($type == $menu_route['menu_type_2']) { ?>
                                            <option value="<?php echo $type; ?>" selected="selected"><?php echo $name; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $type; ?>"><?php echo $name; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select></td>
                            <td class="left" id="menu-route-row<?php echo $route_row; ?>">
                                <div class="values submenu"
                                     style="<?php echo $menu_route['menu_type'] != 'submenu' ? 'display:none;' : ''; ?>">
                                    <select name="menu_route[<?php echo $route_row; ?>][submenu]">
                                        <?php foreach ($submenu as $submenu_info) { ?>
                                            <?php if ($submenu_info["menu_id"] == $menu_route['submenu']) { ?>
                                                <option value="<?php echo $submenu_info["menu_id"]; ?>"
                                                        selected="selected"><?php echo addslashes($submenu_info["name"]); ?></option>
                                            <?php } else { ?>
                                                <option
                                                    value="<?php echo $submenu_info["menu_id"]; ?>"><?php echo addslashes($submenu_info["name"]); ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                                <div class="values route"
                                     style="<?php echo $menu_route['menu_type'] != 'route' && $menu_route['menu_type_2'] != 'route' ? 'display:none;' : ''; ?>">
                                    <input type="text" name="menu_route[<?php echo $route_row; ?>][route]"
                                           value="<?php echo $menu_route['route']; ?>"/>
                                </div>
                                <div class="values information"
                                     style="<?php echo $menu_route['menu_type'] != 'information' && $menu_route['menu_type_2'] != 'information' ? 'display:none;' : ''; ?>">
                                    <select name="menu_route[<?php echo $route_row; ?>][information]">
                                        <?php foreach ($information as $information_info) { ?>
                                            <?php if ($information_info["information_id"] == $menu_route['information']) { ?>
                                                <option value="<?php echo $information_info["information_id"]; ?>"
                                                        selected="selected"><?php echo addslashes($information_info["title"]); ?></option>
                                            <?php } else { ?>
                                                <option
                                                    value="<?php echo $information_info["information_id"]; ?>"><?php echo addslashes($information_info["title"]); ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                                <div class="values category"
                                     style="<?php echo $menu_route['menu_type'] != 'category' && $menu_route['menu_type_2'] != 'category' ? 'display:none;' : ''; ?>">
                                    <select name="menu_route[<?php echo $route_row; ?>][category]" style="max-width:200px;">
                                        <?php if ($menu_route['category'] === 0) { ?>
                                            <option value="0" selected="selected">All root categories</option>
                                        <?php } else { ?>
                                            <option value="0">All root categories</option>
                                        <?php } ?>
                                        <?php foreach ($category as $category_info) { ?>
                                            <?php if ($category_info["category_id"] == $menu_route['category']) { ?>
                                                <option value="<?php echo $category_info["category_id"]; ?>"
                                                        selected="selected"><?php echo addslashes($category_info["name"]); ?></option>
                                            <?php } else { ?>
                                                <option
                                                    value="<?php echo $category_info["category_id"]; ?>"><?php echo addslashes($category_info["name"]); ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                                <div class="values html"
                                     style="<?php echo $menu_route['menu_type'] != 'html' ? 'display:none;' : ''; ?>">
                                    <ul class="nav nav-tabs lng_row_<?php echo $route_row; ?>" id="tabs">
                                        <?php foreach ($languages as $language) { ?>
                                            <li><a data-toggle="tab" href="#language<?php echo $language['language_id'] . "_" .
                                                    $route_row; ?>"><img
                                                    src="view/image/flags/<?php echo $language['image']; ?>"
                                                    title="<?php echo $language['name']; ?>" <?php echo $language['name']; ?>
                                                        /></a></li>
                                        <?php } ?>
                                    </ul>
                                    <div>
                                        <?php foreach ($languages as $language) { ?>
                                            <div id="language<?php echo $language['language_id'] . "_" . $route_row; ?>">
                                                <textarea
                                                    id="editor_<?php echo $route_row; ?>_language_<?php echo $language['language_id']; ?>"
                                                    name="menu_route[<?php echo $route_row; ?>][menu_route_description][<?php echo $language['language_id']; ?>][html]"><?php echo isset($menu_route['menu_route_description'][$language['language_id']]) ? $menu_route['menu_route_description'][$language['language_id']]['html'] : ''; ?></textarea>
                                            </div>
                                        <?php } ?>
                                    </div>
                                    <script type="text/javascript">
                                        $('.lng_row_<?php echo $route_row; ?> a').tab();
                                        <?php foreach ($languages as $language) { ?>
                                        $('#editor_<?php echo $route_row; ?>_language_<?php echo $language['language_id']; ?>').summernote({
                                            height: 300
                                        });
                                        <?php } ?>
                                    </script>
                                </div>
                            </td>
                            <td class="left">
                                <span style="line-height:21px;">Sort order: </span><input type="text" size="3"
                                                                                          name="menu_route[<?php echo $route_row; ?>][sort_order]"
                                                                                          value="<?php echo isset($menu_route['sort_order']) ? $menu_route['sort_order'] : ''; ?>"/>
                                <hr/>
                                <?php foreach ($languages as $language) { ?>
                                    <input type="text"
                                           name="menu_route[<?php echo $route_row; ?>][menu_route_description][<?php echo $language['language_id']; ?>][name]"
                                           value="<?php echo isset($menu_route['menu_route_description'][$language['language_id']]) ? $menu_route['menu_route_description'][$language['language_id']]['name'] : ''; ?>"/>
                                    <img src="view/image/flags/<?php echo $language['image']; ?>"
                                         title="<?php echo $language['name']; ?>"/><br/>
                                <?php } ?>
                            </td>
                            <td class="left">
                                <button type="button" onclick="$('#route-row<?php echo $route_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                            </td>
                        </tr>
                        <?php $route_row++; ?>
                        <?php } ?>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="4"></td>
                            <td class="text-left"><button type="button" onclick="addRoute();" data-toggle="tooltip" title="<?php echo $button_add_route; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                        </tr>
                        </tfoot>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript"><!--
    var route_row = <?php echo $route_row; ?>;

    function changeTypeMenu( route_row ){
        $('#menu-route-row' + route_row + ' div.values').css('display', 'none');
        $( "#menu_route_2_" + route_row ).css("display", "none");
        $('#menu-route-row' + route_row + ' div.' + $('#route-row' + route_row + ' select[name="menu_route[' + route_row + '][menu_type]"]').val() ).css('display', 'block');
        if( "submenu" == $('#route-row' + route_row + ' select[name="menu_route[' + route_row + '][menu_type]"]').val() ) {
            $( "#menu_route_2_" + route_row ).css("display", "block");
            $('#menu-route-row' + route_row + ' div.' + $('#route-row' + route_row + ' select[name="menu_route[' + route_row + '][menu_type_2]"]').val() ).css('display', 'block');
        }
    }
    function changeTypeMenu2( route_row ){
        $('#menu-route-row' + route_row + ' div.values').css('display', 'none');
        $('#menu-route-row' + route_row + ' div.' + $('#route-row' + route_row + ' select[name="menu_route[' + route_row + '][menu_type]"]').val() ).css('display', 'block');
        $('#menu-route-row' + route_row + ' div.' + $('#route-row' + route_row + ' select[name="menu_route[' + route_row + '][menu_type_2]"]').val() ).css('display', 'block');
    }

    function addRoute() {
        html  = '<tbody id="route-row' + route_row + '">';
        html += '  <tr>';
        html += '    <td  style="display:none;" class="left"><select name="menu_route[' + route_row + '][store_id]">';
        html += '    <option value="0"><?php echo $text_default; ?></option>';
        <?php foreach ($stores as $store) { ?>
        html += '<option value="<?php echo $store['store_id']; ?>"><?php echo addslashes($store['name']); ?></option>';
        <?php } ?>
        html += '    </select></td>';
        html += '    <td class="left"><a href="" id="thumb-image' + route_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="menu_route[' + route_row + '][image]" value="" id="input-image' + route_row + '"/></td>';
        html += '    <td class="left"><select name="menu_route[' + route_row + '][menu_type]" onchange="changeTypeMenu(\'' + route_row + '\');">';
        <?php foreach ($types as $type => $name) { ?>
        html += '<option value="<?php echo $type; ?>"><?php echo addslashes( $name ); ?></option>';
        <?php } ?>
        html += '    </select>';
        html += '    <br/><select id="menu_route_2_' + route_row + '" style="display:none;" name="menu_route[' + route_row + '][menu_type_2]" onchange="changeTypeMenu2(\'' + route_row + '\');">';
        <?php foreach ($types2 as $type => $name) { ?>
        html += '<option value="<?php echo $type; ?>"><?php echo addslashes( $name ); ?></option>';
        <?php } ?>
        html += '    </select></td>';
        html += '    <td class="left" id="menu-route-row' + route_row + '">';
        html += '       <div class="values submenu" style="display:none;"><select name="menu_route[' + route_row + '][submenu]">';
        <?php foreach ($submenu as $submenu_info) { ?>
        html += '         <option value="<?php echo $submenu_info["menu_id"]; ?>"><?php echo addslashes( $submenu_info["name"] ); ?></option>';
        <?php } ?>
        html += '       </select></div>';
        html += '       <div class="values route"><input type="text" name="menu_route[' + route_row + '][route]" value="" /></div>';
        html += '       <div class="values information" style="display:none;"><select name="menu_route[' + route_row + '][information]">';
        <?php foreach ($information as $information_info) { ?>
        html += '         <option value="<?php echo $information_info["information_id"]; ?>"><?php echo addslashes( $information_info["title"] ); ?></option>';
        <?php } ?>
        html += '       </select></div>';
        html += '       <div class="values category" style="display:none;"><select style="max-width:200px;" name="menu_route[' + route_row + '][category]">';
        <?php foreach ($category as $category_info) { ?>
        html += '         <option value="<?php echo $category_info["category_id"]; ?>"><?php echo addslashes( $category_info["name"] ); ?></option>';
        <?php } ?>
        html += '       </select></div>';
        html += '       <div class="values html" style="display:none;" >';
        html += '         <ul id="tabs" class="nav nav-tabs lng_row_' + route_row + '">';
        <?php foreach ($languages as $language) { ?>
        html += '             <li><a data-toggle="tab" href="#language<?php echo $language['language_id'] . "_"; ?>' + route_row + '"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" <?php echo $language['name']; ?> /></a></li>';
        <?php } ?>
        html += '         </ul><div style="height:340px;">';
        <?php foreach ($languages as $language) { ?>
        html += '             <div id="language<?php echo $language['language_id'] . "_"; ?>' + route_row + '">';
        html += '                 <textarea id="editor_' + route_row + '_language_<?php echo $language['language_id']; ?>" name="menu_route[' + route_row + '][menu_route_description][<?php echo $language['language_id']; ?>][html]"></textarea>';
        html += '             </div>';
        <?php } ?>
        html += '	</div>';
        html += '    </td>';
        html += '    <td class="left">';
        html += '      <span style="line-height:21px;">Сортировка: </span><input type="text" size="3" name="menu_route[' + route_row + '][sort_order]" value="" /><hr />';
        <?php foreach ($languages as $language) { ?>
        html += '    <input type="text" name="menu_route[' + route_row + '][menu_route_description][<?php echo $language['language_id']; ?>][name]" value="" /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />';
        <?php } ?>
        html += '    </td>';
        html += '    <td class="left"><button type="button" onclick="$(\'#route-row' + route_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
        html += '  </tr>';
        html += '</tbody>';

        $('#route > tfoot').before(html);

        $('.lng_row_' + route_row + ' a').tab();

        <?php foreach ($languages as $language) { ?>
        $('#editor_' + route_row + '_language_<?php echo $language['language_id']; ?>').summernote({
            height: 300
        });
        <?php } ?>


        route_row++;
    }
    //--></script>
<?php echo $footer; ?>
