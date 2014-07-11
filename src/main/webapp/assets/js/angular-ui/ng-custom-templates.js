angular.module('ng-custom-template', []).run(['$templateCache', function($templateCache) {
  'use strict';

  $templateCache.put('template/accordion/accordion-group.html',
    "<div class=\"panel panel-default\"><div class=panel-heading><h4 class=panel-title><a class=accordion-toggle ng-click=toggleOpen() accordion-transclude=heading><span ng-class=\"{'text-muted': isDisabled}\">{{heading}}</span></a></h4></div><div class=panel-collapse collapse=!isOpen><div class=panel-body ng-transclude></div></div></div>"
  );


  $templateCache.put('template/accordion/accordion.html',
    "<div class=panel-group ng-transclude></div>"
  );


  $templateCache.put('template/alert/alert.html',
    "<div class=alert ng-class=\"['alert-' + (type || 'warning'), closeable ? 'alert-dismissable' : null]\" role=alert><button ng-show=closeable type=button class=close ng-click=close()><span aria-hidden=true>&times;</span> <span class=sr-only>Close</span></button><div ng-transclude></div></div>"
  );


  $templateCache.put('template/datepicker/datepicker.html',
    "<div ng-switch=datepickerMode role=application ng-keydown=keydown($event)><daypicker ng-switch-when=day tabindex=0></daypicker><monthpicker ng-switch-when=month tabindex=0></monthpicker><yearpicker ng-switch-when=year tabindex=0></yearpicker></div>"
  );


  $templateCache.put('template/datepicker/day.html',
    "<table role=grid aria-labelledby={{uniqueId}}-title aria-activedescendant={{activeDateId}}><thead><tr><th><button type=button class=\"btn btn-default btn-sm pull-left\" ng-click=move(-1) tabindex=-1><i class=\"glyphicon glyphicon-chevron-left\"></i></button></th><th colspan=\"{{5 + showWeeks}}\"><button id={{uniqueId}}-title role=heading aria-live=assertive aria-atomic=true type=button class=\"btn btn-default btn-sm\" ng-click=toggleMode() tabindex=-1 style=width:100%><strong>{{title}}</strong></button></th><th><button type=button class=\"btn btn-default btn-sm pull-right\" ng-click=move(1) tabindex=-1><i class=\"glyphicon glyphicon-chevron-right\"></i></button></th></tr><tr><th ng-show=showWeeks class=text-center></th><th ng-repeat=\"label in labels track by $index\" class=text-center><small aria-label={{label.full}}>{{label.abbr}}</small></th></tr></thead><tbody><tr ng-repeat=\"row in rows track by $index\"><td ng-show=showWeeks class=\"text-center h6\"><em>{{ weekNumbers[$index] }}</em></td><td ng-repeat=\"dt in row track by dt.date\" class=text-center role=gridcell id={{dt.uid}} aria-disabled={{!!dt.disabled}}><button type=button style=width:100% class=\"btn btn-default btn-sm\" ng-class=\"{'btn-info': dt.selected, active: isActive(dt)}\" ng-click=select(dt.date) ng-disabled=dt.disabled tabindex=-1><span ng-class=\"{'text-muted': dt.secondary, 'text-info': dt.current}\">{{dt.label}}</span></button></td></tr></tbody></table>"
  );


  $templateCache.put('template/datepicker/month.html',
    "<table role=grid aria-labelledby={{uniqueId}}-title aria-activedescendant={{activeDateId}}><thead><tr><th><button type=button class=\"btn btn-default btn-sm pull-left\" ng-click=move(-1) tabindex=-1><i class=\"glyphicon glyphicon-chevron-left\"></i></button></th><th><button id={{uniqueId}}-title role=heading aria-live=assertive aria-atomic=true type=button class=\"btn btn-default btn-sm\" ng-click=toggleMode() tabindex=-1 style=width:100%><strong>{{title}}</strong></button></th><th><button type=button class=\"btn btn-default btn-sm pull-right\" ng-click=move(1) tabindex=-1><i class=\"glyphicon glyphicon-chevron-right\"></i></button></th></tr></thead><tbody><tr ng-repeat=\"row in rows track by $index\"><td ng-repeat=\"dt in row track by dt.date\" class=text-center role=gridcell id={{dt.uid}} aria-disabled={{!!dt.disabled}}><button type=button style=width:100% class=\"btn btn-default\" ng-class=\"{'btn-info': dt.selected, active: isActive(dt)}\" ng-click=select(dt.date) ng-disabled=dt.disabled tabindex=-1><span ng-class=\"{'text-info': dt.current}\">{{dt.label}}</span></button></td></tr></tbody></table>"
  );


  $templateCache.put('template/datepicker/popup.html',
    "<ul class=dropdown-menu ng-style=\"{display: (isOpen && 'block') || 'none', top: position.top+'px', left: position.left+'px'}\" ng-keydown=keydown($event)><li ng-transclude></li><li ng-if=showButtonBar style=\"padding:10px 9px 2px\"><span class=btn-group><button type=button class=\"btn btn-sm btn-info\" ng-click=\"select('today')\">{{ getText('current') }}</button> <button type=button class=\"btn btn-sm btn-danger\" ng-click=select(null)>{{ getText('clear') }}</button></span> <button type=button class=\"btn btn-sm btn-success pull-right\" ng-click=close()>{{ getText('close') }}</button></li></ul>"
  );


  $templateCache.put('template/datepicker/year.html',
    "<table role=grid aria-labelledby={{uniqueId}}-title aria-activedescendant={{activeDateId}}><thead><tr><th><button type=button class=\"btn btn-default btn-sm pull-left\" ng-click=move(-1) tabindex=-1><i class=\"glyphicon glyphicon-chevron-left\"></i></button></th><th colspan=3><button id={{uniqueId}}-title role=heading aria-live=assertive aria-atomic=true type=button class=\"btn btn-default btn-sm\" ng-click=toggleMode() tabindex=-1 style=width:100%><strong>{{title}}</strong></button></th><th><button type=button class=\"btn btn-default btn-sm pull-right\" ng-click=move(1) tabindex=-1><i class=\"glyphicon glyphicon-chevron-right\"></i></button></th></tr></thead><tbody><tr ng-repeat=\"row in rows track by $index\"><td ng-repeat=\"dt in row track by dt.date\" class=text-center role=gridcell id={{dt.uid}} aria-disabled={{!!dt.disabled}}><button type=button style=width:100% class=\"btn btn-default\" ng-class=\"{'btn-info': dt.selected, active: isActive(dt)}\" ng-click=select(dt.date) ng-disabled=dt.disabled tabindex=-1><span ng-class=\"{'text-info': dt.current}\">{{dt.label}}</span></button></td></tr></tbody></table>"
  );


  $templateCache.put('template/modal/backdrop.html',
    "<div class=\"modal-backdrop fade {{ backdropClass }}\" ng-class=\"{in: animate}\" ng-style=\"{'z-index': 1040 + (index && 1 || 0) + index*10}\"></div>"
  );


  $templateCache.put('template/modal/window.html',
    "<div tabindex=-1 role=dialog class=\"modal fade\" ng-class=\"{in: animate}\" ng-style=\"{'z-index': 1050 + index*10, display: 'block'}\" ng-click=close($event)><div class=modal-dialog ng-class=\"{'modal-sm': size == 'sm', 'modal-lg': size == 'lg'}\"><div class=modal-content modal-transclude></div></div></div>"
  );


  $templateCache.put('template/pagination/pager.html',
    "<ul class=pager><li ng-class=\"{disabled: noPrevious(), previous: align}\"><a href ng-click=\"selectPage(page - 1)\">{{getText('previous')}}</a></li><li ng-class=\"{disabled: noNext(), next: align}\"><a href ng-click=\"selectPage(page + 1)\">{{getText('next')}}</a></li></ul>"
  );


  $templateCache.put('template/pagination/pagination.html',
    "<ul class=pagination><li ng-if=boundaryLinks ng-class=\"{disabled: noPrevious()}\"><a href ng-click=selectPage(1)>{{getText('first')}}</a></li><li ng-if=directionLinks ng-class=\"{disabled: noPrevious()}\"><a href ng-click=\"selectPage(page - 1)\">{{getText('previous')}}</a></li><li ng-repeat=\"page in pages track by $index\" ng-class=\"{active: page.active}\"><a href ng-click=selectPage(page.number)>{{page.text}}</a></li><li ng-if=directionLinks ng-class=\"{disabled: noNext()}\"><a href ng-click=\"selectPage(page + 1)\">{{getText('next')}}</a></li><li ng-if=boundaryLinks ng-class=\"{disabled: noNext()}\"><a href ng-click=selectPage(totalPages)>{{getText('last')}}</a></li></ul>"
  );


  $templateCache.put('template/popover/popover.html',
    "<div class=\"popover {{placement}}\" ng-class=\"{ in: isOpen(), fade: animation() }\"><div class=arrow></div><div class=popover-inner><h3 class=popover-title ng-bind=title ng-show=title></h3><div class=popover-content ng-bind=content></div></div></div>"
  );


  $templateCache.put('template/progressbar/bar.html',
    "<div class=progress-bar ng-class=\"type && 'progress-bar-' + type\" role=progressbar aria-valuenow={{value}} aria-valuemin=0 aria-valuemax={{max}} ng-style=\"{width: percent + '%'}\" aria-valuetext=\"{{percent | number:0}}%\" ng-transclude></div>"
  );


  $templateCache.put('template/progressbar/progress.html',
    "<div class=progress ng-transclude></div>"
  );


  $templateCache.put('template/progressbar/progressbar.html',
    "<div class=progress><div class=progress-bar ng-class=\"type && 'progress-bar-' + type\" role=progressbar aria-valuenow={{value}} aria-valuemin=0 aria-valuemax={{max}} ng-style=\"{width: percent + '%'}\" aria-valuetext=\"{{percent | number:0}}%\" ng-transclude></div></div>"
  );


  $templateCache.put('template/tabs/tab.html',
    "<li ng-class=\"{active: active, disabled: disabled}\"><a ng-click=select() tab-heading-transclude>{{heading}}</a></li>"
  );


  $templateCache.put('template/tabs/tabset.html',
    "<div><ul class=\"nav nav-{{type || 'tabs'}}\" ng-class=\"{'nav-stacked': vertical, 'nav-justified': justified}\" ng-transclude></ul><div class=tab-content><div class=tab-pane ng-repeat=\"tab in tabs\" ng-class=\"{active: tab.active}\" tab-content-transclude=tab></div></div></div>"
  );


  $templateCache.put('template/timepicker/timepicker.html',
    "<table><tbody><tr class=text-center><td><a ng-click=incrementHours() class=\"btn btn-link\"><span class=\"glyphicon glyphicon-chevron-up\"></span></a></td><td>&nbsp;</td><td><a ng-click=incrementMinutes() class=\"btn btn-link\"><span class=\"glyphicon glyphicon-chevron-up\"></span></a></td><td ng-show=showMeridian></td></tr><tr><td style=width:50px class=form-group ng-class=\"{'has-error': invalidHours}\"><input ng-model=hours ng-change=updateHours() class=\"form-control text-center\" ng-mousewheel=incrementHours() ng-readonly=readonlyInput maxlength=2></td><td>:</td><td style=width:50px class=form-group ng-class=\"{'has-error': invalidMinutes}\"><input ng-model=minutes ng-change=updateMinutes() class=\"form-control text-center\" ng-readonly=readonlyInput maxlength=2></td><td ng-show=showMeridian><button type=button class=\"btn btn-default text-center\" ng-click=toggleMeridian()>{{meridian}}</button></td></tr><tr class=text-center><td><a ng-click=decrementHours() class=\"btn btn-link\"><span class=\"glyphicon glyphicon-chevron-down\"></span></a></td><td>&nbsp;</td><td><a ng-click=decrementMinutes() class=\"btn btn-link\"><span class=\"glyphicon glyphicon-chevron-down\"></span></a></td><td ng-show=showMeridian></td></tr></tbody></table>"
  );


  $templateCache.put('template/tooltip/tooltip-html-unsafe-popup.html',
    "<div class=\"tooltip {{placement}}\" ng-class=\"{ in: isOpen(), fade: animation() }\"><div class=tooltip-arrow></div><div class=tooltip-inner bind-html-unsafe=content></div></div>"
  );


  $templateCache.put('template/tooltip/tooltip-popup.html',
    "<div class=\"tooltip {{placement}}\" ng-class=\"{ in: isOpen(), fade: animation() }\"><div class=tooltip-arrow></div><div class=tooltip-inner ng-bind=content></div></div>"
  );


  $templateCache.put('template/typeahead/typeahead-match.html',
    "<a tabindex=-1 bind-html-unsafe=\"match.label | typeaheadHighlight:query\"></a>"
  );


  $templateCache.put('template/typeahead/typeahead-popup.html',
    "<ul class=dropdown-menu ng-if=isOpen() ng-style=\"{top: position.top+'px', left: position.left+'px'}\" style=\"display: block\" role=listbox aria-hidden={{!isOpen()}}><li ng-repeat=\"match in matches track by $index\" ng-class=\"{active: isActive($index) }\" ng-mouseenter=selectActive($index) ng-click=selectMatch($index) role=option id={{match.id}}><div typeahead-match index=$index match=match query=query template-url=templateUrl></div></li></ul>"
  );

}]);
