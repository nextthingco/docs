'use strict';

var gulp = require('gulp');
var autoprefixer = require('gulp-autoprefixer');
var minifycss = require('gulp-minify-css');
var plumber = require('gulp-plumber');
var rename = require('gulp-rename');
var sass = require('gulp-sass');
var del = require('del');

gulp.task('css', () => {
  return gulp.src('src/main.scss')
    .pipe(plumber())
    .pipe(sass.sync({
      'outputStyle': 'expanded',
      'precision': 10
    }).on('error', sass.logError))
    .pipe(autoprefixer('last 2 version'))
    .pipe(rename({suffix: '.min'}))
    .pipe(minifycss({'keepSpecialComments': 0}))
    .pipe(gulp.dest('public'));
});

gulp.task('clean', () => {
  return del(['public/*.css']);
});

gulp.task('default', ['clean'], () => {
  return gulp.start('css');
});

gulp.task('watch', ['css'], () => {
  gulp.watch('src/**/*.scss', ['css']);
});
