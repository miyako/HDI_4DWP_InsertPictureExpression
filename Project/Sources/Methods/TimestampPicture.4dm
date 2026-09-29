//%attributes = {"invisible":true}

#DECLARE->$picture : Picture

var $timestamp; $svg; $rect; $svgText : Text
var $p : Integer

$timestamp:=Timestamp:C1445
$p:=Position:C15("T"; $timestamp)
$timestamp:=Substring:C12($timestamp; 1; $p-1)+Char:C90(Carriage return:K15:38)+Substring:C12($timestamp; $p)

$svg:=SVG_New(200; 200)
$rect:=SVG_New_rect($svg; 30; 60; 140; 80)


$svgText:=SVG_New_textArea($svg; $timestamp; 20; 76; 160; 60; "times"; 18; Bold:K14:2; 3)

SVG_SET_FILL_BRUSH($svgText; "grey")
//SVG_SET_OPACITY ($svgText;50)
SVG_SET_TRANSFORM_ROTATE($svg; -30; 100; 100)

$picture:=SVG_Export_to_picture($svg)

CONVERT PICTURE:C1002($picture; ".png")
