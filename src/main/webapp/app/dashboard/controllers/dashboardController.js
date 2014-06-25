angular.module('angularDashboardApp').controller('DashboardController', function($scope) {
	$scope.options = {
        chart: {
            type: 'discreteBarChart',
            height: 500,
            margin : {
                top: 20,
                right: 20,
                bottom: 60,
                left: 55
            },
            x: function(d){ return d.label; },
            y: function(d){ return d.value; },
            showValues: true,
            valueFormat: function(d){
                return d3.format(',')(d);
            },
            transitionDuration: 500,
            xAxis: {
                axisLabel: 'Data Entities',
                rotateLabels: -20
            },
            yAxis: {
                axisLabel: 'Application usage %',
                axisLabelDistance: 30
            }
        },
        title: {
            enable: true,
            text: '% Usage in Applcations'
        }
    };

	$scope.data = [{
        key: "Cumulative Return",
        values: [
            { "label" : "Account Coding" , "value" : 29 },
            { "label" : "Employee" , "value" : 10 },
            { "label" : "Customer" , "value" : 90 },
            { "label" : "Trading" , "value" : 50 },
            { "label" : "Revenue" , "value" : 4 },
            { "label" : "CRM" , "value" : 32 },
            { "label" : "HR" , "value" : 13 },
            { "label" : "Legal" , "value" : 5 }
        ]
    }];
});