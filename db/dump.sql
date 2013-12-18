PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
INSERT INTO "schema_migrations" VALUES('20131216223604');
INSERT INTO "schema_migrations" VALUES('20131217001047');
INSERT INTO "schema_migrations" VALUES('20131217011823');
INSERT INTO "schema_migrations" VALUES('20131218153705');
CREATE TABLE "cms_sites" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "label" varchar(255) NOT NULL, "identifier" varchar(255) NOT NULL, "hostname" varchar(255) NOT NULL, "path" varchar(255), "locale" varchar(255) DEFAULT 'en' NOT NULL, "is_mirrored" boolean DEFAULT 'f' NOT NULL);
INSERT INTO "cms_sites" VALUES(1,'Juice Box','juice-box','0.0.0.0:3000','','en','f');
CREATE TABLE "cms_layouts" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "site_id" integer NOT NULL, "parent_id" integer, "app_layout" varchar(255), "label" varchar(255) NOT NULL, "identifier" varchar(255) NOT NULL, "content" text(16777215), "css" text(16777215), "js" text(16777215), "position" integer DEFAULT 0 NOT NULL, "is_shared" boolean DEFAULT 'f' NOT NULL, "created_at" datetime, "updated_at" datetime);
INSERT INTO "cms_layouts" VALUES(1,1,NULL,'application','Default','default','<h1> {{ cms:page:title:string }} </h1>
{{ cms:page:content }}','','',0,'f','2013-12-16 22:39:26.370328','2013-12-16 23:00:39.228443');
CREATE TABLE "cms_pages" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "site_id" integer NOT NULL, "layout_id" integer, "parent_id" integer, "target_page_id" integer, "label" varchar(255) NOT NULL, "slug" varchar(255), "full_path" varchar(255) NOT NULL, "content" text(16777215), "position" integer DEFAULT 0 NOT NULL, "children_count" integer DEFAULT 0 NOT NULL, "is_published" boolean DEFAULT 't' NOT NULL, "is_shared" boolean DEFAULT 'f' NOT NULL, "created_at" datetime, "updated_at" datetime);
INSERT INTO "cms_pages" VALUES(1,1,1,NULL,NULL,'Home',NULL,'/','<h1> Juice Box </h1>
Welcome to our new website. Your mind = blown.',0,3,'t','f','2013-12-16 22:40:00.951996','2013-12-16 23:01:19.837103');
INSERT INTO "cms_pages" VALUES(2,1,1,1,NULL,'Bio','bio','/bio','<h1> Ingredients </h1>
No preservatives here.

<ul>
  <li>Ashley Hamel - Vox</li>
  <li>Doug Parkinson - Vox / Guitar</li>
  <li>Eric Riotte - Bass</li>
  <li>Mike Cristaldi - Drums</li>
</ul>',0,0,'t','f','2013-12-17 00:01:12.634084','2013-12-17 00:01:12.634084');
INSERT INTO "cms_pages" VALUES(4,1,1,1,NULL,'Media','media','/media','<h1> Video, Pictures, MP3s </h1>
Coming Soon.

<br /><br />

<iframe width="560" height="315" src="//www.youtube.com/embed/IuSi96Ru5HU?list=UUdGPwd1aiWH-pVLb23bfcfQ" frameborder="0" allowfullscreen></iframe>',2,0,'t','f','2013-12-17 00:36:21.687985','2013-12-17 00:36:49.585345');
INSERT INTO "cms_pages" VALUES(5,1,1,1,NULL,'Contact','contact','/contact','<h1> Get in Touch with Us </h1>
We''re fun. Does the <a href="mailto:booking@rockyourjuicebox.com?subject=Juice Box Contact Form">booking@rockyourjuicebox.com</a> still work?',3,0,'t','f','2013-12-17 00:44:01.326409','2013-12-17 00:52:10.958721');
CREATE TABLE "cms_blocks" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "page_id" integer NOT NULL, "identifier" varchar(255) NOT NULL, "content" text(16777215), "created_at" datetime, "updated_at" datetime);
INSERT INTO "cms_blocks" VALUES(1,1,'header','rock your JUICE BOX','2013-12-16 22:40:00.960822','2013-12-16 22:47:31.205096');
INSERT INTO "cms_blocks" VALUES(2,1,'content','Welcome to our new website. Your mind = blown.','2013-12-16 22:40:00.971720','2013-12-16 23:01:19.843448');
INSERT INTO "cms_blocks" VALUES(3,1,'title','Juice Box','2013-12-16 23:01:19.849130','2013-12-16 23:01:19.849130');
INSERT INTO "cms_blocks" VALUES(4,2,'title','Ingredients','2013-12-17 00:01:12.647487','2013-12-17 00:01:12.647487');
INSERT INTO "cms_blocks" VALUES(5,2,'content','No preservatives here.

<ul>
  <li>Ashley Hamel - Vox</li>
  <li>Doug Parkinson - Vox / Guitar</li>
  <li>Eric Riotte - Bass</li>
  <li>Mike Cristaldi - Drums</li>
</ul>','2013-12-17 00:01:12.655364','2013-12-17 00:01:12.655364');
INSERT INTO "cms_blocks" VALUES(8,4,'title','Video, Pictures, MP3s','2013-12-17 00:36:21.698049','2013-12-17 00:36:21.698049');
INSERT INTO "cms_blocks" VALUES(9,4,'content','Coming Soon.

<br /><br />

<iframe width="560" height="315" src="//www.youtube.com/embed/IuSi96Ru5HU?list=UUdGPwd1aiWH-pVLb23bfcfQ" frameborder="0" allowfullscreen></iframe>','2013-12-17 00:36:21.704273','2013-12-17 00:36:49.590737');
INSERT INTO "cms_blocks" VALUES(10,5,'title','Get in Touch with Us','2013-12-17 00:44:01.333270','2013-12-17 00:44:01.333270');
INSERT INTO "cms_blocks" VALUES(11,5,'content','We''re fun. Does the <a href="mailto:booking@rockyourjuicebox.com?subject=Juice Box Contact Form">booking@rockyourjuicebox.com</a> still work?','2013-12-17 00:44:01.338258','2013-12-17 00:52:10.964073');
CREATE TABLE "cms_snippets" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "site_id" integer NOT NULL, "label" varchar(255) NOT NULL, "identifier" varchar(255) NOT NULL, "content" text(16777215), "position" integer DEFAULT 0 NOT NULL, "is_shared" boolean DEFAULT 'f' NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "cms_files" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "site_id" integer NOT NULL, "block_id" integer, "label" varchar(255) NOT NULL, "file_file_name" varchar(255) NOT NULL, "file_content_type" varchar(255) NOT NULL, "file_file_size" integer NOT NULL, "description" varchar(2048), "position" integer DEFAULT 0 NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "cms_revisions" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "record_type" varchar(255) NOT NULL, "record_id" integer NOT NULL, "data" text(16777215), "created_at" datetime);
INSERT INTO "cms_revisions" VALUES(1,'Cms::Page',1,'---
blocks_attributes:
- :identifier: content
  :content: Test Test Test
- :identifier: header
  :content: Title?
','2013-12-16 22:47:31.211581');
INSERT INTO "cms_revisions" VALUES(2,'Cms::Layout',1,'---
content: "<html>\r\n  <body>\r\n    <h1>{{ cms:page:header:string }}</h1>\r\n    {{
  cms:page:content:text }}\r\n  </body>\r\n</html>"
css: ''''
js: ''''
','2013-12-16 22:48:09.193555');
INSERT INTO "cms_revisions" VALUES(3,'Cms::Layout',1,'---
content: "<html>\r\n  <body>\r\n    <img src=\"images/logo.jpg\" alt=\"Juice Box Logo\"
  />\r\n    <h1>{{ cms:page:header:string }}</h1>\r\n    {{ cms:page:content:text
  }}\r\n  </body>\r\n</html>"
css: ''''
js: ''''
','2013-12-16 22:52:15.505936');
INSERT INTO "cms_revisions" VALUES(4,'Cms::Layout',1,'---
content: "<html>\r\n  <body>\r\n    <img src=\"static/images/logo.jpg\" alt=\"Juice
  Box Logo\" />\r\n    <h1>{{ cms:page:header:string }}</h1>\r\n    {{ cms:page:content:text
  }}\r\n  </body>\r\n</html>"
css: ''''
js: ''''
','2013-12-16 22:56:49.037346');
INSERT INTO "cms_revisions" VALUES(5,'Cms::Layout',1,'---
content: "<html>\r\n  <body>\r\n    <% image_tag \"logo.jpg\" %>\r\n    <h1>{{ cms:page:header:string
  }}</h1>\r\n    {{ cms:page:content:text }}\r\n  </body>\r\n</html>"
css: ''''
js: ''''
','2013-12-16 22:58:33.053547');
INSERT INTO "cms_revisions" VALUES(6,'Cms::Layout',1,'---
content: ''''
css: ''''
js: ''''
','2013-12-16 23:00:39.235393');
INSERT INTO "cms_revisions" VALUES(7,'Cms::Page',1,'---
blocks_attributes:
- :identifier: content
  :content: Test Test Test
- :identifier: header
  :content: rock your JUICE BOX
- :identifier: title
  :content: 
','2013-12-16 23:01:19.851794');
INSERT INTO "cms_revisions" VALUES(8,'Cms::Page',4,'---
blocks_attributes:
- :identifier: content
  :content: "Coming Soon.\r\n\r\n<iframe width=\"560\" height=\"315\" src=\"//www.youtube.com/embed/IuSi96Ru5HU?list=UUdGPwd1aiWH-pVLb23bfcfQ\"
    frameborder=\"0\" allowfullscreen></iframe>"
- :identifier: title
  :content: Video, Pictures, MP3s
','2013-12-17 00:36:49.597318');
INSERT INTO "cms_revisions" VALUES(9,'Cms::Page',5,'---
blocks_attributes:
- :identifier: content
  :content: We''re fun.
- :identifier: title
  :content: Get in Touch with Us
','2013-12-17 00:52:10.965994');
CREATE TABLE "cms_categories" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "site_id" integer NOT NULL, "label" varchar(255) NOT NULL, "categorized_type" varchar(255) NOT NULL);
CREATE TABLE "cms_categorizations" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "category_id" integer NOT NULL, "categorized_type" varchar(255) NOT NULL, "categorized_id" integer NOT NULL);
CREATE TABLE "blogs" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "site_id" integer NOT NULL, "label" varchar(255) NOT NULL, "identifier" varchar(255) NOT NULL, "app_layout" varchar(255) DEFAULT 'application' NOT NULL, "path" varchar(255), "description" text);
INSERT INTO "blogs" VALUES(1,1,'Story Time','story-time','application','','The Juice Box blog!');
CREATE TABLE "blog_posts" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "blog_id" integer NOT NULL, "title" varchar(255) NOT NULL, "slug" varchar(255) NOT NULL, "content" text, "excerpt" varchar(1024), "author" varchar(255), "year" integer(4) NOT NULL, "month" integer(2) NOT NULL, "is_published" boolean DEFAULT 't' NOT NULL, "published_at" datetime NOT NULL, "created_at" datetime, "updated_at" datetime);
INSERT INTO "blog_posts" VALUES(1,1,'Welcome to the Web','welcome-to-the-web','The time has come for a real website. I''ve been against this for a while now because, well, I never saw any point to doing one. But the time has come and this site is being brought to you by Ruby on Rails and Heroku. Special thanks to the Comfortable Mexican Sofa people on GitHub too.

This blog will be used to document any funny or otherwise memorable moments that happen to us at gigs or practices. Stay tuned.','','Eric',2013,12,'t','2013-12-17 00:13:46.000000','2013-12-17 00:15:43.530689','2013-12-18 17:31:21.116089');
CREATE TABLE "blog_comments" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "post_id" integer NOT NULL, "author" varchar(255) NOT NULL, "email" varchar(255) NOT NULL, "content" text, "is_published" boolean DEFAULT 'f' NOT NULL, "created_at" datetime, "updated_at" datetime);
INSERT INTO "blog_comments" VALUES(1,1,'Eric','eriotte@gmail.com','This blog is amazing. The form is pathetic.','t','2013-12-17 00:20:44.755440','2013-12-17 00:20:59.884859');
CREATE TABLE "songs" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "title" varchar(255), "artist" varchar(255), "year" integer, "created_at" datetime, "updated_at" datetime);
INSERT INTO "songs" VALUES(1,'Purple Haze','Jimi Hendrix',1967,'2013-12-17 01:24:41.423103','2013-12-18 17:13:11.680179');
INSERT INTO "songs" VALUES(2,'Troublemaker','Olly Murs',2012,'2013-12-17 01:25:49.485902','2013-12-17 01:25:49.485902');
INSERT INTO "songs" VALUES(3,'Eye of the Tiger','Survivor',1982,'2013-12-17 01:27:02.767623','2013-12-17 01:27:02.767623');
CREATE TABLE "events" ("id" INTEGER PRIMARY KEY SERIAL NOT NULL, "name" varchar(255), "date" date, "location" varchar(255), "fb_link" varchar(255), "created_at" datetime, "updated_at" datetime);
INSERT INTO "events" VALUES(1,'La Boca Mexican Restaurant & Cantina','2014-01-04','337 Main St., Middletown, Connecticut 06457','https://www.facebook.com/events/457012634404821/','2013-12-18 15:39:09.839193','2013-12-18 16:23:33.141705');
INSERT INTO "events" VALUES(2,'The Black Rose','2014-01-11','1076 Main St, Newington, CT 06111','','2013-12-18 16:22:28.097868','2013-12-18 16:22:28.097868');
INSERT INTO "events" VALUES(3,'La Boca Mexican Restaurant & Cantina','2014-02-15','337 Main St., Middletown, Connecticut 06457','','2013-12-18 18:15:38.142763','2013-12-18 18:24:56.865251');
INSERT INTO "events" VALUES(4,'The Black Rose','2014-03-01','1076 Main St, Newington, CT 06111','','2013-12-18 18:16:07.128735','2013-12-18 18:25:20.037552');
INSERT INTO "events" VALUES(5,'La Boca Mexican Restaurant & Cantina','2014-03-28','337 Main St., Middletown, Connecticut 06457','','2013-12-18 18:17:10.072823','2013-12-18 18:18:22.816878');
INSERT INTO "events" VALUES(6,'McLadden''s Irish Publick House','2014-04-26','37 Lasalle Road West Hartford, CT','','2013-12-18 18:17:39.702069','2013-12-18 18:19:41.089150');
INSERT INTO "events" VALUES(7,'The Black Rose','2014-05-17','1076 Main St, Newington, CT 06111','','2013-12-18 18:20:46.364316','2013-12-18 18:20:46.364316');
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('cms_sites',1);
INSERT INTO "sqlite_sequence" VALUES('cms_layouts',1);
INSERT INTO "sqlite_sequence" VALUES('cms_pages',5);
INSERT INTO "sqlite_sequence" VALUES('cms_blocks',11);
INSERT INTO "sqlite_sequence" VALUES('cms_revisions',9);
INSERT INTO "sqlite_sequence" VALUES('cms_files',1);
INSERT INTO "sqlite_sequence" VALUES('blogs',1);
INSERT INTO "sqlite_sequence" VALUES('blog_posts',1);
INSERT INTO "sqlite_sequence" VALUES('blog_comments',1);
INSERT INTO "sqlite_sequence" VALUES('songs',3);
INSERT INTO "sqlite_sequence" VALUES('events',7);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE INDEX "index_cms_sites_on_hostname" ON "cms_sites" ("hostname");
CREATE INDEX "index_cms_sites_on_is_mirrored" ON "cms_sites" ("is_mirrored");
CREATE INDEX "index_cms_layouts_on_parent_id_and_position" ON "cms_layouts" ("parent_id", "position");
CREATE UNIQUE INDEX "index_cms_layouts_on_site_id_and_identifier" ON "cms_layouts" ("site_id", "identifier");
CREATE INDEX "index_cms_pages_on_site_id_and_full_path" ON "cms_pages" ("site_id", "full_path");
CREATE INDEX "index_cms_pages_on_parent_id_and_position" ON "cms_pages" ("parent_id", "position");
CREATE INDEX "index_cms_blocks_on_page_id_and_identifier" ON "cms_blocks" ("page_id", "identifier");
CREATE UNIQUE INDEX "index_cms_snippets_on_site_id_and_identifier" ON "cms_snippets" ("site_id", "identifier");
CREATE INDEX "index_cms_snippets_on_site_id_and_position" ON "cms_snippets" ("site_id", "position");
CREATE INDEX "index_cms_files_on_site_id_and_label" ON "cms_files" ("site_id", "label");
CREATE INDEX "index_cms_files_on_site_id_and_file_file_name" ON "cms_files" ("site_id", "file_file_name");
CREATE INDEX "index_cms_files_on_site_id_and_position" ON "cms_files" ("site_id", "position");
CREATE INDEX "index_cms_files_on_site_id_and_block_id" ON "cms_files" ("site_id", "block_id");
CREATE INDEX "index_cms_revisions_on_rtype_and_rid_and_created_at" ON "cms_revisions" ("record_type", "record_id", "created_at");
CREATE UNIQUE INDEX "index_cms_categories_on_site_id_and_categorized_type_and_label" ON "cms_categories" ("site_id", "categorized_type", "label");
CREATE UNIQUE INDEX "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id" ON "cms_categorizations" ("category_id", "categorized_type", "categorized_id");
CREATE INDEX "index_blogs_on_site_id_and_path" ON "blogs" ("site_id", "path");
CREATE INDEX "index_blogs_on_identifier" ON "blogs" ("identifier");
CREATE INDEX "index_blog_posts_on_published_year_month_slug" ON "blog_posts" ("is_published", "year", "month", "slug");
CREATE INDEX "index_blog_posts_on_is_published_and_created_at" ON "blog_posts" ("is_published", "created_at");
CREATE INDEX "index_blog_posts_on_created_at" ON "blog_posts" ("created_at");
CREATE INDEX "index_blog_comments_on_post_id_and_created_at" ON "blog_comments" ("post_id", "created_at");
CREATE INDEX "index_blog_comments_on_post_published_created" ON "blog_comments" ("post_id", "is_published", "created_at");
COMMIT;
