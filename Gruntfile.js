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
            options: {
                livereload: true,
            },
            reloadFiles: {
                files: ['public/*.html',"public/js/*.js", "public/css/*.css"]
            },
            
        },

        nodemon: {
            dev: {
                options: {
                    file: 'js/node_server.js'
                }
            }
        }



	});

    grunt.loadNpmTasks('grunt-nodemon');
    grunt.loadNpmTasks('grunt-concurrent');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-peon-gui');

    // grunt.registerTask('default', ['watch']);
    // grunt.registerTask('watch', ['watch']);
    grunt.registerTask('default', ['concurrent:target']);
};