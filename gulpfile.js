var gulp = require('gulp');
var del = require('del');

var liveServer = require('gulp-live-server');
var sequence = require('gulp-sequence').use(gulp);
var coffee = require('gulp-coffee');
var uglify = require('gulp-uglify');
var jade = require('gulp-jade');
var sass = require('gulp-ruby-sass');
var autoprefixer = require('gulp-autoprefixer');
var csso = require('gulp-csso');
var imagemin = require('gulp-imagemin');
var concat = require('gulp-concat');
var rev = require('gulp-rev');
var replace = require('gulp-replace');
var inject = require('gulp-inject');
var wiredep = require('wiredep').stream;
var usemin = require('gulp-usemin');
var minifyCss = require('gulp-minify-css');

// 启动服务
gulp.task('connect', function() {
   var server = liveServer('server.js');
   server.start().then(function(result) {
      console.log('Server exited with result:', result);
      process.exit(result.code);
   });
   //gulp.watch(['static/**/*.css', 'static/**/*.html'], server.notify);
   //gulp.watch('server.js', server.start);
});
// 设置环境变量
gulp.task('setEnvVariable', function() {
   var profile = require('./env/dev');
   var stream = gulp.src('dist/libs/scripts/constants.js');
   for (var key in profile) {
      stream = stream.pipe(replace('@@'+key, profile[key])).pipe(gulp.dest('dist/libs/scripts'))
   }
   return stream
});
// 删除dist文件夹
gulp.task('del', function () {
   return del(['dist'])
});
// coffee编译
gulp.task('coffee', function () {
   var stream = gulp.src('public/libs/scripts/**/*.coffee')
       .pipe(coffee({bare: true}))
       .on('error', function(err) {
            console.log(err)
       })
       .pipe(gulp.dest('dist/libs/scripts'));
   return gulp.src('public/scripts/**/*.coffee')
       .pipe(coffee({bare: true}))
       .on('error', function(err) {
          console.log(err)
       })
       .pipe(gulp.dest('dist/scripts'));
});
// js压缩
gulp.task('uglify', function () {
   return gulp.src('dist/libs/scripts/**/*.js').pipe(uglify({compress: true, mangle: false})).pipe(gulp.dest('dist/libs/scripts'))
});
// concat js
gulp.task('concatJs', function () {
   var stream = gulp.src('dist/libs/scripts/**/*.js')
       .pipe(concat('libs.js'))
       .pipe(uglify({compress: true, mangle: false}))
       .pipe(gulp.dest('dist/libs'));
   return gulp.src('dist/scripts/**/*.js')
       .pipe(concat('main.js'))
       .pipe(uglify({compress: true, mangle: false}))
       .pipe(gulp.dest('dist/scripts'))
});
// jade编译
gulp.task('jade', function() {
   return gulp.src('public/views/**/*.jade').pipe(jade()).pipe(gulp.dest('dist/views'))
});
// sass编译
gulp.task('sass', function() {
   return sass('public/libs/sasses/**/*.sass').on('error', sass.logError).pipe(gulp.dest('dist/libs/css'))
});
// css加前缀
gulp.task('autoprefixer', function () {
   return gulp.src('dist/libs/css/**/*.css').pipe(autoprefixer()).pipe(gulp.dest('dist/libs/css'))
});
// css 压缩
gulp.task('cssmin', function () {
   return gulp.src('dist/libs/css/**/*.css').pipe(csso()).pipe(gulp.dest('dist/libs/css'))
});
// concat css
gulp.task('concatCss', function() {
   return gulp.src('dist/libs/css/**/*.css')
       .pipe(concat('main.css'))
       .pipe(csso())
       .pipe(gulp.dest('dist/libs'))
});
// 图片压缩
gulp.task('imagemin', function() {
   return gulp.src('public/libs/images/*').pipe(imagemin()).pipe(gulp.dest('dist/libs/images'))
});
// copy fonts
gulp.task('copy', function () {
   return gulp.src('public/libs/fonts/*').pipe(gulp.dest('dist/libs/fonts'))
});
// 添加版本号
gulp.task('rev', function () {
   return gulp.src('dist/libs/*').pipe(rev()).pipe(gulp.dest('dist/libs'))
});
// min
gulp.task('usemin', function () {
   return gulp.src('dist/views/index.html')
     .pipe(usemin({
       css: [minifyCss(), rev()],
       jsVendor: [uglify({mangle: false}), rev()],
       jsMain: [uglify({mangle: false}), rev()]
     }))
     .pipe(gulp.dest('dist/views'))
});
// index inject
gulp.task('inject', function() {
   var target = gulp.src('dist/views/index.html');
   var sources = gulp.src(['dist/**/*.js', 'dist/**/*.css'], {read: false});
   return target.pipe(inject(sources, {relative: true})).pipe(gulp.dest('dist/views'));
});
// npm package inject
gulp.task('bower', function () {
   return gulp.src('dist/views/index.html')
     .pipe(wiredep({
        directory: 'node_modules',
        bowerJson: require('./package.json')
     }))
     .pipe(gulp.dest('dist/views'))
});

gulp.task('default', sequence('del', 'coffee', 'setEnvVariable', 'concatJs'));
gulp.task('test', sequence('del', 'jade', 'coffee', 'inject', 'bower', 'usemin'));
gulp.task('serve', sequence(
    'del',
    'coffee',
    'setEnvVariable',
    'uglify',
    //'concatJs',
    'jade',
    'sass',
    'autoprefixer',
    'cssmin',
    //'concatCss',
    'imagemin',
    'copy',
    'bower',
    'inject',
    'usemin',
    'connect'
));
