---
layout: post
title: 워드프레스 수정 사항 정리
description: "워드프레스 수정 사항 정리"
category: blog
tags: [ blog, wordpress ]
published: true
---

* TOC
{:toc}

## 2014.05.30

### FD Feedburner 플러그인에서 태그는 리다이렉트되지 않도록 수정

fdfeedburner.php 파일에서 다음 코드를 주석 처리한다.

    if ($options['feedburner_append_cats'] == 1 && $tag) {
        $feed_url .= '_'.$tag;
    }



## 2014.02.23

### 공유버튼을 수동으로 추가.

[Wordpress.com](http://Wordpress.com)에 있는 공유버튼 스타일을 가져다 썼다. 현재 [blog.kalkin7.com](http://blog.kalkin7.com)의 "Twenty Twelve"의 Child 테마인 "2012 ffwd" 테마에 적용한 상태. style.css와 content.php를 수정했다.

**1**\. content.php에서 다음 코드를 찾는다.

~~~ php
?php wp_link_pages
~~~

**2**\. 위의 코드 바로 위에 다음 링크의 코드를 붙여 넣는다. [wordpress social share button](http://pastebin.com/GQf15tVQ)

**3**\. style.css에 다음 코드를 추가한다.

~~~ css
div.sd-wrapper{padding-top:10px;}
div.sd-wrapper div.sd-block{border-top:1px solid rgba(0, 0, 0, 0.13);margin:0;padding:10px 0 5px;width:100% !important;}
.sd-wrapper h3{background:none repeat scroll 0 0 rgba(0, 0, 0, 0);border:medium none;float:left;font-family:나눔고딕,"맑은 고딕",NanumGothic,"Malgun Gothic",Arial,sans-serif;font-size:14px;font-weight:bold;letter-spacing:0;line-height:1;margin:3px 0;padding:0;position:static;text-transform:none;width:15.625%;}
.sd-content ul{list-style:none outside none !important;margin:0 0 0.7em !important;padding:0 !important;}
.sd-content ul li{margin:0 !important;padding:0;}
.sd-content ul li{display:inline;}
.sd-content ul li a.sd-button:before{display:inline-block;position:relative;text-align:center;top:-2px;vertical-align:top;}
.sd-social-icon .sd-content ul li a.sd-button, .sd-content ul li a.sd-button, .sd-content ul li.advanced a.share-more, .sd-wrapper .sd-content ul li a.sd-button{background:none repeat scroll 0 0 #F8F8F8;border:1px solid #CCCCCC;border-radius:3px;box-shadow:0 1px 0 rgba(0, 0, 0, 0.08);color:#777777 !important;display:inline-block;font-family:나눔고딕,"맑은 고딕",NanumGothic,"Malgun Gothic","Open Sans",sans-serif;font-size:13px;font-weight:normal;line-height:1;margin:0 5px 5px 0;padding:4px 5px 4px 5px;text-decoration:none !important;text-shadow:none;}
.sd-content > ul > li > a.sd-button{box-shadow:none;padding:3px 6px 0 3px;vertical-align:top;}
.sd-content ul li a.sd-button:hover, .sd-content ul li a.sd-button:active, .sd-content ul li a.sd-button:hover, .sd-content ul li a.sd-button:active, .sd-content > ul > li > a.sd-button:hover, .sd-content > ul > li > a.sd-button:active, .sd-content > ul > li .digg_button > a:hover{background:none repeat scroll 0 0 #FAFAFA;border:1px solid #888888 !important;color:#555555;}
.sd-social-icon-text .sd-content ul li a.sd-button:active{box-shadow:0 1px 0 rgba(0, 0, 0, 0.16) inset;}
.sd-content ul li[class*="share-"] a:hover{border:medium none;opacity:0.6;}
~~~


### sem external links 플러그인 css 테마의 style.css에 통합

요청회수를 줄이기 위해서 sem external link 플러그인의 css를 테마에 포함시켰다. 그리고 플러그인에서 자체 css를 또 추가하는 것을 방지하기 위해서 플러그인 파일도 수정했다.



### `the_post_thumbnail();` 을 젯팩 포톤(photon)이 인식하지 못할 때가 있어서 다음 코드로 수정
    $featured_image = wp_get_attachment_image_src(get_post_thumbnail_id($post->ID), 'full'); // get thumbnail image url
    $photon_featured_image_url= $featured_image[0];
    echo "<img src='".$photon_featured_image_url."' class='wp-post-image'> ";




## 2014.02.21

### Admin Bar에 WP Super Cache 캐시 삭제 페이지로 가능 링크를 추가

- **참조 링크**: [Add Shortcut Links to the Toolbar - Digwp.com](http://digwp.com/2012/06/shortcut-links-toolbar/ "Add Shortcut Links to the Toolbar - Digwp.com")

- **적용 방법**

테마의 function.php를 열고 마지막에 다음 코드를 추가한다.

	// add a link to the WP Toolbar
	function custom_toolbar_link($wp_admin_bar) {
		$args = array(
			'id' => 'gmail',
			'title' => 'Gmail', 
			'href' => 'https://mail.google.com/mail/#inbox', 
			'meta' => array(
				'class' => 'gmail', 
				'title' => 'sales@digwp.com'
				)
		);
		$wp_admin_bar->add_node($args);
	}
	add_action('admin_bar_menu', 'custom_toolbar_link', 999);

위 코드에서 id, title, class, title는 그냥 마음대로 지정하면 된다. 즉, 중요한 것은 "**href**"다.