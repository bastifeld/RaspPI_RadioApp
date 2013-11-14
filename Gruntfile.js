module.exports = function(grunt) {

	grunt.initConfig({
    
        concurrent: {
            target: {
                tasks: ['nodemon', 'watch'],
                options: {
                    logConcurrentOutput: true
                }
            }
            
        },
   

        watch: {
            
            reloadFiles: {
                files: ['public/*.html',"public/js/main.js", "public/css/*.css"],
                options: {
                    livereload: true,
                },
            },

           /* browserify: {
                files: ["public/js/*.js","!public/js/main.js"],
                tasks: ['browserify:basic'],
            },*/
            
        },

        nodemon: {
            dev: {
                options: {
                    file: 'js/node_server.js',
                    ignoredFiles: ['public/**'],

                }
            }
        },

        browserify: {
            basic: {
                src: ['public/coffee/app.coffee'],
                dest: 'public/js/main.js',
                options: {
                    transform: ['coffeeify'],
                    debug: true,
                    sourceMapRoot: 'public/coffee/app'
                }
            }
        },

        less: {
            development: {
                options: {
                     cleancss: false
                },
                files: {
                    "public/css/style.css": "public/less/style.less"
                }
            }
        },

        coffee: {
            glob_to_multiple: {
                expand: true,
                flatten: true,
                cwd: 'coffee/',
                src: ['*.coffee'],
                dest: 'js/',
                ext: '.js'
  }
        }
	});

    grunt.loadNpmTasks('grunt-nodemon');
    grunt.loadNpmTasks('grunt-concurrent');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-peon-gui');
    grunt.loadNpmTasks('grunt-browserify');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-coffee');

    grunt.registerTask('build', ['browserify','less', 'coffee']);
    // grunt.registerTask('default', ['watch']);
    // grunt.registerTask('watch', ['watch']);
    grunt.registerTask('default', ['concurrent:target']);
};