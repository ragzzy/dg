//task runner
module.exports = function (grunt) {
    
    require('load-grunt-tasks')(grunt);

    grunt.initConfig({        
        pkg: grunt.file.readJSON('package.json'),

        less: {
            main: {
                files: {
                    //output                            :  input
                    'assets/css/less-base/core.css': 'assets/css/less-base/core.less'
                }
            }
        },

        cssmin: {
            main: {
                files: {
                    //output
                    'assets/css/core-combined.css':
                    [
                        //input
                        'assets/css/font-icons/entypo/css/entypo.css',
                        'assets/css/font-icons/font-awesome/css/font-awesome.css',
                        'assets/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css',
                        'assets/js/ng-grid/ng-grid.css',
                        'assets/js/angular-dialog/dialogs.css',
                        'assets/css/less-base/core.css'
                    ]
                }
            }
        },
        
        autoprefixer: {
            options: { browsers: ['last 2 versions', '> 5%', 'ie 7'] },
            all: {
                files: {
                    //output    :   Input
                    'assets/css/core.min.css': 'assets/css/core-combined.css'
                }
            }
        },
        
        //create custom templates of angular boostrap UI to a nre module for dep injection into template cache
        ngtemplates: {
            options: {
                standalone: true,
                module: 'ng-custom-template',
                htmlmin: {
                    collapseBooleanAttributes: true,
                    collapseWhitespace: true,
                    removeAttributeQuotes: true,
                    removeComments: true,
                    removeEmptyAttributes: true,
                    removeRedundantAttributes: true,
                    removeScriptTypeAttributes: true,
                    removeStyleLinkTypeAttributes: true
                }
            },
            ngmultiple: {
                cwd:
                   'assets/js/angular-ui/',
                src:
                    [
                        'template/**/*.html'
                    ],
                dest: 'assets/js/angular-ui/ng-custom-templates.js'
            }
        },

        uglify: {
            main: {
                report: 'min',
                files: {
                    //Output
                    'assets/js/core.js': [
                        //input
                        "assets/js/gsap/main-gsap.js",
                        "assets/js/bootstrap.js",
                        "assets/js/joinable.js",
                        "assets/js/resizeable.js",
                        "assets/js/jquery.validate.min.js",
                        "assets/js/jquery.inputmask.bundle.min.js",
                        "assets/js/base-api.js",
                        "assets/js/base-custom.js",
                        "assets/js/base-demo.js",
                        "assets/js/base-forgotpassword.js",
                        "assets/js/base-login.js",
                        "assets/js/base-register.js"
                    ]
                }
            }
        }
    });
    
    //dev grunt:
    grunt.registerTask('default', ['less', 'cssmin', 'autoprefixer', 'ngtemplates']);
    //prod: grunt.registerTask('default', ['less', 'cssmin', 'uglify']);
}