var gulp = require('gulp'),
    plumber = require('gulp-plumber'),
    coffee = require('gulp-coffee'),
    concat = require('gulp-concat'),
    del = require('del');

gulp.task('clean', function (cb) {
  del(['public'],cb);
});

gulp.task('coffee', function () {
    gulp.src('coffee/*.coffee')
    .pipe(plumber())
    //.pipe(sourcemaps.init())
    .pipe(coffee())
    //.pipe(sourcemaps.write())
    .pipe(concat('app.js'))
    .pipe(gulp.dest('public'));
});

gulp.task('copy', function () {
  var inputs = [
    'index.html',
    'css/*.css',
    'node_modules/jquery/dist/jquery.min.js',
    'node_modules/q/q.js'
  ];
  gulp.src(inputs)
    .pipe(gulp.dest('public'));
});

gulp.task('default', ['coffee','copy']);

gulp.task('watch', ['default'], function(){
  gulp.watch(['index.html','css/*.css'], ['copy']);
  gulp.watch(['coffee/*.coffee'], ['coffee']);
});
