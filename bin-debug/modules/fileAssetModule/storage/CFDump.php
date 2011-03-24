
    

  

<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
        <title>CFDump.php at master from rickosborne/php-fw1 - GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />

    <link href="https://d3nwyuy0nl342s.cloudfront.net/b3091bd0632b07457de744de1c8022f33a6a6fbd/stylesheets/bundle_common.css" media="screen" rel="stylesheet" type="text/css" />
<link href="https://d3nwyuy0nl342s.cloudfront.net/b3091bd0632b07457de744de1c8022f33a6a6fbd/stylesheets/bundle_github.css" media="screen" rel="stylesheet" type="text/css" />
    

    <script type="text/javascript">
      if (typeof console == "undefined" || typeof console.log == "undefined")
        console = { log: function() {} }
    </script>
    <script type="text/javascript" charset="utf-8">
      var GitHub = {
        assetHost: 'https://d3nwyuy0nl342s.cloudfront.net'
      }
      var github_user = 'renz45'
      
    </script>
    <script src="https://d3nwyuy0nl342s.cloudfront.net/b3091bd0632b07457de744de1c8022f33a6a6fbd/javascripts/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="https://d3nwyuy0nl342s.cloudfront.net/b3091bd0632b07457de744de1c8022f33a6a6fbd/javascripts/bundle_common.js" type="text/javascript"></script>
<script src="https://d3nwyuy0nl342s.cloudfront.net/b3091bd0632b07457de744de1c8022f33a6a6fbd/javascripts/bundle_github.js" type="text/javascript"></script>


    
    <script type="text/javascript" charset="utf-8">
      GitHub.spy({
        repo: "rickosborne/php-fw1"
      })
    </script>

    
  <link href="https://github.com/rickosborne/php-fw1/commits/master.atom" rel="alternate" title="Recent Commits to php-fw1:master" type="application/atom+xml" />

        <meta name="description" content="PHP port of Sean Corfield's FW/1 ColdFusion MVC framework" />
    <script type="text/javascript">
      GitHub.nameWithOwner = GitHub.nameWithOwner || "rickosborne/php-fw1";
      GitHub.currentRef = 'master';
      GitHub.commitSHA = "e825c2f27e6ff4c25d01e46712518bced9c825aa";
      GitHub.currentPath = 'CFDump.php';
      GitHub.masterBranch = "master";

      
    </script>
  

        <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-3769691-2']);
      _gaq.push(['_setDomainName', 'none']);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script');
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        ga.setAttribute('async', 'true');
        document.documentElement.firstChild.appendChild(ga);
      })();
    </script>

    
  </head>

  

  <body class="logged_in page-blob">
    

    

    

    

    

    <div class="subnavd" id="main">
      <div id="header" class="true">
        
          <a class="logo boring" href="https://github.com/">
            <img alt="github" class="default" src="https://d3nwyuy0nl342s.cloudfront.net/images/modules/header/logov3.png" />
            <!--[if (gt IE 8)|!(IE)]><!-->
            <img alt="github" class="hover" src="https://d3nwyuy0nl342s.cloudfront.net/images/modules/header/logov3-hover.png" />
            <!--<![endif]-->
          </a>
        
        
          





  
    <div class="userbox">
      <div class="avatarname">
        <a href="https://github.com/renz45"><img src="https://secure.gravatar.com/avatar/7f65227b993e15cd1a49c7248453d7e9?s=140&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png" alt="" width="20" height="20"  /></a>
        <a href="https://github.com/renz45" class="name">renz45</a>

        
        
      </div>
      <ul class="usernav">
        <li><a href="https://github.com/">Dashboard</a></li>
        <li>
          
          <a href="https://github.com/inbox">Inbox</a>
          <a href="https://github.com/inbox" class="unread_count ">0</a>
        </li>
        <li><a href="https://github.com/account">Account Settings</a></li>
                <li><a href="/logout">Log Out</a></li>
      </ul>
    </div><!-- /.userbox -->
  


        
        <div class="topsearch">
  
    <form action="/search" id="top_search_form" method="get">
      <a href="/search" class="advanced-search tooltipped downwards" title="Advanced Search">Advanced Search</a>
      <input type="search" class="search my_repos_autocompleter" name="q" results="5" placeholder="Search&hellip;" /> <input type="submit" value="Search" class="button" />
      <input type="hidden" name="type" value="Everything" />
      <input type="hidden" name="repo" value="" />
      <input type="hidden" name="langOverride" value="" />
      <input type="hidden" name="start_value" value="1" />
    </form>
    <ul class="nav">
      <li><a href="/explore">Explore GitHub</a></li>
      <li><a href="https://gist.github.com">Gist</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="http://help.github.com">Help</a></li>
    </ul>
  
</div>

      </div>

      
      
        
    <div class="site">
      <div class="pagehead repohead vis-public   ">

      

      <div class="title-actions-bar">
        <h1>
          <a href="/rickosborne">rickosborne</a> / <strong><a href="https://github.com/rickosborne/php-fw1">php-fw1</a></strong>
          
          
        </h1>

        
    <ul class="actions">
      

      
        <li class="for-owner" style="display:none"><a href="https://github.com/rickosborne/php-fw1/admin" class="minibutton btn-admin "><span><span class="icon"></span>Admin</span></a></li>
        <li>
          <a href="/rickosborne/php-fw1/toggle_watch" class="minibutton btn-watch " id="watch_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'ab67165e78fcb9f93528eeea28be343320ac7844'); f.appendChild(s);f.submit();return false;" style="display:none"><span><span class="icon"></span>Watch</span></a>
          <a href="/rickosborne/php-fw1/toggle_watch" class="minibutton btn-watch " id="unwatch_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'ab67165e78fcb9f93528eeea28be343320ac7844'); f.appendChild(s);f.submit();return false;" style="display:none"><span><span class="icon"></span>Unwatch</span></a>
        </li>
        
          
            <li class="for-notforked" style="display:none"><a href="/rickosborne/php-fw1/fork" class="minibutton btn-fork " id="fork_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'ab67165e78fcb9f93528eeea28be343320ac7844'); f.appendChild(s);f.submit();return false;"><span><span class="icon"></span>Fork</span></a></li>
            <li class="for-hasfork" style="display:none"><a href="#" class="minibutton btn-fork " id="your_fork_button"><span><span class="icon"></span>Your Fork</span></a></li>
          

          <li id='pull_request_item' class='nspr' style='display:none'><a href="/rickosborne/php-fw1/pull/new/master" class="minibutton btn-pull-request "><span><span class="icon"></span>Pull Request</span></a></li>
        
      
      
      <li class="repostats">
        <ul class="repo-stats">
          <li class="watchers"><a href="/rickosborne/php-fw1/watchers" title="Watchers" class="tooltipped downwards">4</a></li>
          <li class="forks"><a href="/rickosborne/php-fw1/network" title="Forks" class="tooltipped downwards">1</a></li>
        </ul>
      </li>
    </ul>

      </div>

        
  <ul class="tabs">
    <li><a href="https://github.com/rickosborne/php-fw1" class="selected" highlight="repo_source">Source</a></li>
    <li><a href="https://github.com/rickosborne/php-fw1/commits/master" highlight="repo_commits">Commits</a></li>
    <li><a href="/rickosborne/php-fw1/network" highlight="repo_network">Network</a></li>
    <li><a href="/rickosborne/php-fw1/pulls" highlight="repo_pulls">Pull Requests (0)</a></li>

    

    
      
      <li><a href="/rickosborne/php-fw1/issues" highlight="issues">Issues (0)</a></li>
    

            
    <li><a href="/rickosborne/php-fw1/graphs" highlight="repo_graphs">Graphs</a></li>

    <li class="contextswitch nochoices">
      <span class="toggle leftwards" >
        <em>Branch:</em>
        <code>master</code>
      </span>
    </li>
  </ul>

  <div style="display:none" id="pl-description"><p><em class="placeholder">click here to add a description</em></p></div>
  <div style="display:none" id="pl-homepage"><p><em class="placeholder">click here to add a homepage</em></p></div>

  <div class="subnav-bar">
  
  <ul>
    <li>
      <a href="#" class="dropdown">Switch Branches (1)</a>
      <ul>
        
          
            <li><strong>master &#x2713;</strong></li>
            
      </ul>
    </li>
    <li>
      <a href="#" class="dropdown defunct">Switch Tags (0)</a>
      
    </li>
    <li>
    
    <a href="/rickosborne/php-fw1/branches" class="manage">Branch List</a>
    
    </li>
  </ul>
</div>

  
  
  
  
  
  



        
    <div class="frame frame-center tree-finder" style="display: none">
      <div class="breadcrumb">
        <b><a href="/rickosborne/php-fw1">php-fw1</a></b> /
        <input class="tree-finder-input" type="text" name="query" autocomplete="off" spellcheck="false">
      </div>

      
        <div class="octotip">
          <p>
            <a href="/rickosborne/php-fw1/dismiss-tree-finder-help" class="dismiss js-dismiss-tree-list-help" title="Hide this notice forever">Dismiss</a>
            <strong>Octotip:</strong> You've activated the <em>file finder</em> by pressing <span class="kbd">t</span>
            Start typing to filter the file list. Use <span class="kbd badmono">↑</span> and <span class="kbd badmono">↓</span> to navigate,
            <span class="kbd">enter</span> to view files.
          </p>
        </div>
      

      <table class="tree-browser" cellpadding="0" cellspacing="0">
        <tr class="js-header"><th>&nbsp;</th><th>name</th></tr>
        <tr class="js-no-results no-results" style="display: none">
          <th colspan="2">No matching files</th>
        </tr>
        <tbody class="js-results-list">
        </tbody>
      </table>
    </div>

    <div id="jump-to-line" style="display:none">
      <h2>Jump to Line</h2>
      <form>
        <input class="textfield" type="text">
        <div class="full-button">
          <button type="submit" class="classy">
            <span>Go</span>
          </button>
        </div>
      </form>
    </div>

    <div id="repo_details" class="metabox clearfix">
      <div id="repo_details_loader" class="metabox-loader" style="display:none">Sending Request&hellip;</div>

        <a href="/rickosborne/php-fw1/downloads" class="download-source" id="download_button" title="Download source, tagged packages and binaries."><span class="icon"></span>Downloads</a>

      <div id="repository_desc_wrapper">
      <div id="repository_description" rel="repository_description_edit">
        
          <p>PHP port of Sean Corfield's FW/1 ColdFusion MVC framework
            <span id="read_more" style="display:none">&mdash; <a href="#readme">Read more</a></span>
          </p>
        
      </div>

      <div id="repository_description_edit" style="display:none;" class="inline-edit">
        <form action="/rickosborne/php-fw1/admin/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="ab67165e78fcb9f93528eeea28be343320ac7844" /></div>
          <input type="hidden" name="field" value="repository_description">
          <input type="text" class="textfield" name="value" value="PHP port of Sean Corfield's FW/1 ColdFusion MVC framework">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>

      
      <div class="repository-homepage" id="repository_homepage" rel="repository_homepage_edit">
        <p><a href="http://" rel="nofollow"></a></p>
      </div>

      <div id="repository_homepage_edit" style="display:none;" class="inline-edit">
        <form action="/rickosborne/php-fw1/admin/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="ab67165e78fcb9f93528eeea28be343320ac7844" /></div>
          <input type="hidden" name="field" value="repository_homepage">
          <input type="text" class="textfield" name="value" value="">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>
      </div>
      <div class="rule "></div>
            <div id="url_box" class="url-box">
        <ul class="clone-urls">
          
            
            <li id="http_clone_url"><a href="https://github.com/rickosborne/php-fw1.git" data-permissions="Read-Only">HTTP</a></li>
            <li id="public_clone_url"><a href="git://github.com/rickosborne/php-fw1.git" data-permissions="Read-Only">Git Read-Only</a></li>
          
          
        </ul>
        <input type="text" spellcheck="false" id="url_field" class="url-field" />
              <span style="display:none" id="url_box_clippy"></span>
      <span id="clippy_tooltip_url_box_clippy" class="clippy-tooltip tooltipped" title="copy to clipboard">
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="14"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="https://d3nwyuy0nl342s.cloudfront.net/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=url_box_clippy&amp;copied=&amp;copyto=">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="https://d3nwyuy0nl342s.cloudfront.net/flash/clippy.swf?v5"
             width="14"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=url_box_clippy&amp;copied=&amp;copyto="
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      </span>

        <p id="url_description">This URL has <strong>Read+Write</strong> access</p>
      </div>
    </div>


        

      </div><!-- /.pagehead -->

      

  





<script type="text/javascript">
  GitHub.downloadRepo = '/rickosborne/php-fw1/archives/master'
  GitHub.revType = "master"

  GitHub.controllerName = "blob"
  GitHub.actionName     = "show"
  GitHub.currentAction  = "blob#show"

  
    GitHub.hasWriteAccess = false
    GitHub.hasAdminAccess = false
    GitHub.watchingRepo = false
    GitHub.ignoredRepo = false
    GitHub.hasForkOfRepo = ""
    GitHub.hasForked = false
  

  
</script>






<div class="flash-messages"></div>


  <div id="commit">
    <div class="group">
        
  <div class="envelope commit">
    <div class="human">
      
        <div class="message"><pre><a href="/rickosborne/php-fw1/commit/e825c2f27e6ff4c25d01e46712518bced9c825aa">New CFDump class for just that functionality, now with XML magic</a> </pre></div>
      

      <div class="actor">
        <div class="gravatar">
          
          <img src="https://secure.gravatar.com/avatar/1d02703eb0e34a6aa9b16a4629702de6?s=140&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png" alt="" width="30" height="30"  />
        </div>
        <div class="name">Rick Osborne <span>(author)</span></div>
        <div class="date">
          <abbr class="relatize" title="2011-02-14 09:33:16">Mon Feb 14 09:33:16 -0800 2011</abbr>
        </div>
      </div>

      

    </div>
    <div class="machine">
      <span>c</span>ommit&nbsp;&nbsp;<a href="/rickosborne/php-fw1/commit/e825c2f27e6ff4c25d01e46712518bced9c825aa" hotkey="c">e825c2f27e6ff4c25d01</a><br />
      <span>t</span>ree&nbsp;&nbsp;&nbsp;&nbsp;<a href="/rickosborne/php-fw1/tree/e825c2f27e6ff4c25d01e46712518bced9c825aa" hotkey="t">24e62983a450b3fc79c6</a><br />
      
        <span>p</span>arent&nbsp;
        
        <a href="/rickosborne/php-fw1/tree/e36692501458753c98fb170b804f6f95819d9915" hotkey="p">e36692501458753c98fb</a>
      

    </div>
  </div>

    </div>
  </div>



  <div id="slider">

  

    <div class="breadcrumb" data-path="CFDump.php/">
      <b><a href="/rickosborne/php-fw1/tree/e825c2f27e6ff4c25d01e46712518bced9c825aa">php-fw1</a></b> / CFDump.php       <span style="display:none" id="clippy_1127">CFDump.php</span>
      
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="https://d3nwyuy0nl342s.cloudfront.net/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=clippy_1127&amp;copied=copied!&amp;copyto=copy to clipboard">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="https://d3nwyuy0nl342s.cloudfront.net/flash/clippy.swf?v5"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=clippy_1127&amp;copied=copied!&amp;copyto=copy to clipboard"
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      

    </div>

    <div class="frames">
      <div class="frame frame-center" data-path="CFDump.php/">
        
          <ul class="big-actions">
            
            <li><a class="file-edit-link minibutton" href="/rickosborne/php-fw1/file-edit/__current_ref__/CFDump.php"><span>Edit this file</span></a></li>
          </ul>
        

        <div id="files">
          <div class="file">
            <div class="meta">
              <div class="info">
                <span class="icon"><img alt="Txt" height="16" src="https://d3nwyuy0nl342s.cloudfront.net/images/icons/txt.png" width="16" /></span>
                <span class="mode" title="File Mode">100644</span>
                
                  <span>277 lines (270 sloc)</span>
                
                <span>13.431 kb</span>
              </div>
              <ul class="actions">
                <li><a href="/rickosborne/php-fw1/raw/master/CFDump.php" id="raw-url">raw</a></li>
                
                  <li><a href="/rickosborne/php-fw1/blame/master/CFDump.php">blame</a></li>
                
                <li><a href="/rickosborne/php-fw1/commits/master/CFDump.php">history</a></li>
              </ul>
            </div>
            
  <div class="data type-php">
    
      <table cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <pre class="line_numbers"><span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
<span id="L5" rel="#L5">5</span>
<span id="L6" rel="#L6">6</span>
<span id="L7" rel="#L7">7</span>
<span id="L8" rel="#L8">8</span>
<span id="L9" rel="#L9">9</span>
<span id="L10" rel="#L10">10</span>
<span id="L11" rel="#L11">11</span>
<span id="L12" rel="#L12">12</span>
<span id="L13" rel="#L13">13</span>
<span id="L14" rel="#L14">14</span>
<span id="L15" rel="#L15">15</span>
<span id="L16" rel="#L16">16</span>
<span id="L17" rel="#L17">17</span>
<span id="L18" rel="#L18">18</span>
<span id="L19" rel="#L19">19</span>
<span id="L20" rel="#L20">20</span>
<span id="L21" rel="#L21">21</span>
<span id="L22" rel="#L22">22</span>
<span id="L23" rel="#L23">23</span>
<span id="L24" rel="#L24">24</span>
<span id="L25" rel="#L25">25</span>
<span id="L26" rel="#L26">26</span>
<span id="L27" rel="#L27">27</span>
<span id="L28" rel="#L28">28</span>
<span id="L29" rel="#L29">29</span>
<span id="L30" rel="#L30">30</span>
<span id="L31" rel="#L31">31</span>
<span id="L32" rel="#L32">32</span>
<span id="L33" rel="#L33">33</span>
<span id="L34" rel="#L34">34</span>
<span id="L35" rel="#L35">35</span>
<span id="L36" rel="#L36">36</span>
<span id="L37" rel="#L37">37</span>
<span id="L38" rel="#L38">38</span>
<span id="L39" rel="#L39">39</span>
<span id="L40" rel="#L40">40</span>
<span id="L41" rel="#L41">41</span>
<span id="L42" rel="#L42">42</span>
<span id="L43" rel="#L43">43</span>
<span id="L44" rel="#L44">44</span>
<span id="L45" rel="#L45">45</span>
<span id="L46" rel="#L46">46</span>
<span id="L47" rel="#L47">47</span>
<span id="L48" rel="#L48">48</span>
<span id="L49" rel="#L49">49</span>
<span id="L50" rel="#L50">50</span>
<span id="L51" rel="#L51">51</span>
<span id="L52" rel="#L52">52</span>
<span id="L53" rel="#L53">53</span>
<span id="L54" rel="#L54">54</span>
<span id="L55" rel="#L55">55</span>
<span id="L56" rel="#L56">56</span>
<span id="L57" rel="#L57">57</span>
<span id="L58" rel="#L58">58</span>
<span id="L59" rel="#L59">59</span>
<span id="L60" rel="#L60">60</span>
<span id="L61" rel="#L61">61</span>
<span id="L62" rel="#L62">62</span>
<span id="L63" rel="#L63">63</span>
<span id="L64" rel="#L64">64</span>
<span id="L65" rel="#L65">65</span>
<span id="L66" rel="#L66">66</span>
<span id="L67" rel="#L67">67</span>
<span id="L68" rel="#L68">68</span>
<span id="L69" rel="#L69">69</span>
<span id="L70" rel="#L70">70</span>
<span id="L71" rel="#L71">71</span>
<span id="L72" rel="#L72">72</span>
<span id="L73" rel="#L73">73</span>
<span id="L74" rel="#L74">74</span>
<span id="L75" rel="#L75">75</span>
<span id="L76" rel="#L76">76</span>
<span id="L77" rel="#L77">77</span>
<span id="L78" rel="#L78">78</span>
<span id="L79" rel="#L79">79</span>
<span id="L80" rel="#L80">80</span>
<span id="L81" rel="#L81">81</span>
<span id="L82" rel="#L82">82</span>
<span id="L83" rel="#L83">83</span>
<span id="L84" rel="#L84">84</span>
<span id="L85" rel="#L85">85</span>
<span id="L86" rel="#L86">86</span>
<span id="L87" rel="#L87">87</span>
<span id="L88" rel="#L88">88</span>
<span id="L89" rel="#L89">89</span>
<span id="L90" rel="#L90">90</span>
<span id="L91" rel="#L91">91</span>
<span id="L92" rel="#L92">92</span>
<span id="L93" rel="#L93">93</span>
<span id="L94" rel="#L94">94</span>
<span id="L95" rel="#L95">95</span>
<span id="L96" rel="#L96">96</span>
<span id="L97" rel="#L97">97</span>
<span id="L98" rel="#L98">98</span>
<span id="L99" rel="#L99">99</span>
<span id="L100" rel="#L100">100</span>
<span id="L101" rel="#L101">101</span>
<span id="L102" rel="#L102">102</span>
<span id="L103" rel="#L103">103</span>
<span id="L104" rel="#L104">104</span>
<span id="L105" rel="#L105">105</span>
<span id="L106" rel="#L106">106</span>
<span id="L107" rel="#L107">107</span>
<span id="L108" rel="#L108">108</span>
<span id="L109" rel="#L109">109</span>
<span id="L110" rel="#L110">110</span>
<span id="L111" rel="#L111">111</span>
<span id="L112" rel="#L112">112</span>
<span id="L113" rel="#L113">113</span>
<span id="L114" rel="#L114">114</span>
<span id="L115" rel="#L115">115</span>
<span id="L116" rel="#L116">116</span>
<span id="L117" rel="#L117">117</span>
<span id="L118" rel="#L118">118</span>
<span id="L119" rel="#L119">119</span>
<span id="L120" rel="#L120">120</span>
<span id="L121" rel="#L121">121</span>
<span id="L122" rel="#L122">122</span>
<span id="L123" rel="#L123">123</span>
<span id="L124" rel="#L124">124</span>
<span id="L125" rel="#L125">125</span>
<span id="L126" rel="#L126">126</span>
<span id="L127" rel="#L127">127</span>
<span id="L128" rel="#L128">128</span>
<span id="L129" rel="#L129">129</span>
<span id="L130" rel="#L130">130</span>
<span id="L131" rel="#L131">131</span>
<span id="L132" rel="#L132">132</span>
<span id="L133" rel="#L133">133</span>
<span id="L134" rel="#L134">134</span>
<span id="L135" rel="#L135">135</span>
<span id="L136" rel="#L136">136</span>
<span id="L137" rel="#L137">137</span>
<span id="L138" rel="#L138">138</span>
<span id="L139" rel="#L139">139</span>
<span id="L140" rel="#L140">140</span>
<span id="L141" rel="#L141">141</span>
<span id="L142" rel="#L142">142</span>
<span id="L143" rel="#L143">143</span>
<span id="L144" rel="#L144">144</span>
<span id="L145" rel="#L145">145</span>
<span id="L146" rel="#L146">146</span>
<span id="L147" rel="#L147">147</span>
<span id="L148" rel="#L148">148</span>
<span id="L149" rel="#L149">149</span>
<span id="L150" rel="#L150">150</span>
<span id="L151" rel="#L151">151</span>
<span id="L152" rel="#L152">152</span>
<span id="L153" rel="#L153">153</span>
<span id="L154" rel="#L154">154</span>
<span id="L155" rel="#L155">155</span>
<span id="L156" rel="#L156">156</span>
<span id="L157" rel="#L157">157</span>
<span id="L158" rel="#L158">158</span>
<span id="L159" rel="#L159">159</span>
<span id="L160" rel="#L160">160</span>
<span id="L161" rel="#L161">161</span>
<span id="L162" rel="#L162">162</span>
<span id="L163" rel="#L163">163</span>
<span id="L164" rel="#L164">164</span>
<span id="L165" rel="#L165">165</span>
<span id="L166" rel="#L166">166</span>
<span id="L167" rel="#L167">167</span>
<span id="L168" rel="#L168">168</span>
<span id="L169" rel="#L169">169</span>
<span id="L170" rel="#L170">170</span>
<span id="L171" rel="#L171">171</span>
<span id="L172" rel="#L172">172</span>
<span id="L173" rel="#L173">173</span>
<span id="L174" rel="#L174">174</span>
<span id="L175" rel="#L175">175</span>
<span id="L176" rel="#L176">176</span>
<span id="L177" rel="#L177">177</span>
<span id="L178" rel="#L178">178</span>
<span id="L179" rel="#L179">179</span>
<span id="L180" rel="#L180">180</span>
<span id="L181" rel="#L181">181</span>
<span id="L182" rel="#L182">182</span>
<span id="L183" rel="#L183">183</span>
<span id="L184" rel="#L184">184</span>
<span id="L185" rel="#L185">185</span>
<span id="L186" rel="#L186">186</span>
<span id="L187" rel="#L187">187</span>
<span id="L188" rel="#L188">188</span>
<span id="L189" rel="#L189">189</span>
<span id="L190" rel="#L190">190</span>
<span id="L191" rel="#L191">191</span>
<span id="L192" rel="#L192">192</span>
<span id="L193" rel="#L193">193</span>
<span id="L194" rel="#L194">194</span>
<span id="L195" rel="#L195">195</span>
<span id="L196" rel="#L196">196</span>
<span id="L197" rel="#L197">197</span>
<span id="L198" rel="#L198">198</span>
<span id="L199" rel="#L199">199</span>
<span id="L200" rel="#L200">200</span>
<span id="L201" rel="#L201">201</span>
<span id="L202" rel="#L202">202</span>
<span id="L203" rel="#L203">203</span>
<span id="L204" rel="#L204">204</span>
<span id="L205" rel="#L205">205</span>
<span id="L206" rel="#L206">206</span>
<span id="L207" rel="#L207">207</span>
<span id="L208" rel="#L208">208</span>
<span id="L209" rel="#L209">209</span>
<span id="L210" rel="#L210">210</span>
<span id="L211" rel="#L211">211</span>
<span id="L212" rel="#L212">212</span>
<span id="L213" rel="#L213">213</span>
<span id="L214" rel="#L214">214</span>
<span id="L215" rel="#L215">215</span>
<span id="L216" rel="#L216">216</span>
<span id="L217" rel="#L217">217</span>
<span id="L218" rel="#L218">218</span>
<span id="L219" rel="#L219">219</span>
<span id="L220" rel="#L220">220</span>
<span id="L221" rel="#L221">221</span>
<span id="L222" rel="#L222">222</span>
<span id="L223" rel="#L223">223</span>
<span id="L224" rel="#L224">224</span>
<span id="L225" rel="#L225">225</span>
<span id="L226" rel="#L226">226</span>
<span id="L227" rel="#L227">227</span>
<span id="L228" rel="#L228">228</span>
<span id="L229" rel="#L229">229</span>
<span id="L230" rel="#L230">230</span>
<span id="L231" rel="#L231">231</span>
<span id="L232" rel="#L232">232</span>
<span id="L233" rel="#L233">233</span>
<span id="L234" rel="#L234">234</span>
<span id="L235" rel="#L235">235</span>
<span id="L236" rel="#L236">236</span>
<span id="L237" rel="#L237">237</span>
<span id="L238" rel="#L238">238</span>
<span id="L239" rel="#L239">239</span>
<span id="L240" rel="#L240">240</span>
<span id="L241" rel="#L241">241</span>
<span id="L242" rel="#L242">242</span>
<span id="L243" rel="#L243">243</span>
<span id="L244" rel="#L244">244</span>
<span id="L245" rel="#L245">245</span>
<span id="L246" rel="#L246">246</span>
<span id="L247" rel="#L247">247</span>
<span id="L248" rel="#L248">248</span>
<span id="L249" rel="#L249">249</span>
<span id="L250" rel="#L250">250</span>
<span id="L251" rel="#L251">251</span>
<span id="L252" rel="#L252">252</span>
<span id="L253" rel="#L253">253</span>
<span id="L254" rel="#L254">254</span>
<span id="L255" rel="#L255">255</span>
<span id="L256" rel="#L256">256</span>
<span id="L257" rel="#L257">257</span>
<span id="L258" rel="#L258">258</span>
<span id="L259" rel="#L259">259</span>
<span id="L260" rel="#L260">260</span>
<span id="L261" rel="#L261">261</span>
<span id="L262" rel="#L262">262</span>
<span id="L263" rel="#L263">263</span>
<span id="L264" rel="#L264">264</span>
<span id="L265" rel="#L265">265</span>
<span id="L266" rel="#L266">266</span>
<span id="L267" rel="#L267">267</span>
<span id="L268" rel="#L268">268</span>
<span id="L269" rel="#L269">269</span>
<span id="L270" rel="#L270">270</span>
<span id="L271" rel="#L271">271</span>
<span id="L272" rel="#L272">272</span>
<span id="L273" rel="#L273">273</span>
<span id="L274" rel="#L274">274</span>
<span id="L275" rel="#L275">275</span>
<span id="L276" rel="#L276">276</span>
<span id="L277" rel="#L277">277</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre><div class='line' id='LC1'><span class="cp">&lt;?php</span> </div><div class='line' id='LC2'><span class="k">namespace</span> <span class="nx">org\rickosborne\php</span><span class="p">;</span></div><div class='line' id='LC3'><br/></div><div class='line' id='LC4'><span class="k">class</span> <span class="nc">CFDump</span> <span class="p">{</span></div><div class='line' id='LC5'><br/></div><div class='line' id='LC6'>	<span class="k">public</span> <span class="k">function</span> <span class="nf">__construct</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC7'>		<span class="k">foreach</span> <span class="p">(</span><span class="nb">func_get_args</span><span class="p">()</span> <span class="k">as</span> <span class="nv">$arg</span><span class="p">)</span></div><div class='line' id='LC8'>			<span class="nx">self</span><span class="o">::</span><span class="na">dump</span><span class="p">(</span><span class="nv">$arg</span><span class="p">);</span></div><div class='line' id='LC9'>	<span class="p">}</span> <span class="c1">// ctor</span></div><div class='line' id='LC10'><br/></div><div class='line' id='LC11'>	<span class="sd">/**</span></div><div class='line' id='LC12'><span class="sd">	 * cfdump-style debugging output</span></div><div class='line' id='LC13'><span class="sd">	 * @param $var    The variable to output.</span></div><div class='line' id='LC14'><span class="sd">	 * @param $limit  Maximum recursion depth for arrays (default 0 = all)</span></div><div class='line' id='LC15'><span class="sd">	 * @param $label  text to display in complex data type header</span></div><div class='line' id='LC16'><span class="sd">	 * @param $depth  Current depth (default 0)</span></div><div class='line' id='LC17'><span class="sd">	 */</span></div><div class='line' id='LC18'>	<span class="k">public</span> <span class="k">static</span> <span class="k">function</span> <span class="nf">dump</span><span class="p">(</span><span class="o">&amp;</span><span class="nv">$var</span><span class="p">,</span> <span class="nv">$limit</span> <span class="o">=</span> <span class="m">0</span><span class="p">,</span> <span class="nv">$label</span> <span class="o">=</span> <span class="s1">&#39;&#39;</span><span class="p">,</span> <span class="nv">$depth</span> <span class="o">=</span> <span class="m">0</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC19'>		<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="nb">is_int</span><span class="p">(</span><span class="nv">$depth</span><span class="p">))</span></div><div class='line' id='LC20'>			<span class="nv">$depth</span> <span class="o">=</span> <span class="m">0</span><span class="p">;</span></div><div class='line' id='LC21'>		<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="nb">is_int</span><span class="p">(</span><span class="nv">$limit</span><span class="p">))</span></div><div class='line' id='LC22'>			<span class="nv">$limit</span> <span class="o">=</span> <span class="m">0</span><span class="p">;</span></div><div class='line' id='LC23'>		<span class="k">if</span> <span class="p">((</span><span class="nv">$limit</span> <span class="o">&gt;</span> <span class="m">0</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">(</span><span class="nv">$depth</span> <span class="o">&gt;=</span> <span class="nv">$limit</span><span class="p">))</span></div><div class='line' id='LC24'>			<span class="k">return</span><span class="p">;</span></div><div class='line' id='LC25'>		<span class="k">static</span> <span class="nv">$seen</span> <span class="o">=</span> <span class="k">array</span><span class="p">();</span></div><div class='line' id='LC26'>		<span class="nv">$he</span> <span class="o">=</span> <span class="k">function</span> <span class="p">(</span><span class="nv">$s</span><span class="p">)</span> <span class="p">{</span> <span class="k">return</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$s</span><span class="p">);</span> <span class="p">};</span></div><div class='line' id='LC27'>		<span class="nv">$tabs</span> <span class="o">=</span> <span class="s2">&quot;</span><span class="se">\n</span><span class="s2">&quot;</span> <span class="o">.</span> <span class="nb">str_repeat</span><span class="p">(</span><span class="s2">&quot;</span><span class="se">\t</span><span class="s2">&quot;</span><span class="p">,</span> <span class="nv">$depth</span><span class="p">);</span></div><div class='line' id='LC28'>		<span class="nv">$depth</span><span class="o">++</span><span class="p">;</span></div><div class='line' id='LC29'>		<span class="nv">$printCount</span> <span class="o">=</span> <span class="m">0</span><span class="p">;</span></div><div class='line' id='LC30'>		<span class="nx">self</span><span class="o">::</span><span class="na">dumpCssJs</span><span class="p">();</span></div><div class='line' id='LC31'>		<span class="k">if</span> <span class="p">(</span><span class="nb">is_array</span><span class="p">(</span><span class="nv">$var</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC32'>			<span class="c1">// It turns out that identity (===) in PHP isn&#39;t actually identity.  It&#39;s more like &quot;do you look similar enough to fool an untrained observer?&quot;.  Lame!</span></div><div class='line' id='LC33'>			<span class="c1">// $label = $label === &#39;&#39; ? (($var === $_POST) ? &#39;$_POST&#39; : (($var === $_GET) ? &#39;$_GET&#39; : (($var === $_COOKIE) ? &#39;$_COOKIE&#39; : (($var === $_ENV) ? &#39;$_ENV&#39; : (($var === $_FILES) ? &#39;$_FILES&#39; : (($var === $_REQUEST) ? &#39;$_REQUEST&#39; : (($var === $_SERVER) ? &#39;$_SERVER&#39; : (isset($_SESSION) &amp;&amp; ($var === $_SESSION) ? &#39;$_SESSION&#39; : &#39;&#39;)))))))) : $label;      </span></div><div class='line' id='LC34'>			<span class="nv">$c</span> <span class="o">=</span> <span class="nb">count</span><span class="p">(</span><span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC35'>			<span class="k">if</span><span class="p">(</span><span class="nb">isset</span><span class="p">(</span><span class="nv">$var</span><span class="p">[</span><span class="s1">&#39;fw1recursionsentinel&#39;</span><span class="p">]))</span> <span class="p">{</span></div><div class='line' id='LC36'>				<span class="k">echo</span> <span class="s2">&quot;(Recursion)&quot;</span><span class="p">;</span></div><div class='line' id='LC37'>			<span class="p">}</span></div><div class='line' id='LC38'>			<span class="nv">$aclass</span> <span class="o">=</span> <span class="p">((</span><span class="nv">$c</span> <span class="o">&gt;</span> <span class="m">0</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="nb">array_key_exists</span><span class="p">(</span><span class="m">0</span><span class="p">,</span> <span class="nv">$var</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="nb">array_key_exists</span><span class="p">(</span><span class="nv">$c</span> <span class="o">-</span> <span class="m">1</span><span class="p">,</span> <span class="nv">$var</span><span class="p">))</span> <span class="o">?</span> <span class="s1">&#39;array&#39;</span> <span class="o">:</span> <span class="s1">&#39;struct&#39;</span><span class="p">;</span></div><div class='line' id='LC39'>			<span class="nv">$var</span><span class="p">[</span><span class="s1">&#39;fw1recursionsentinel&#39;</span><span class="p">]</span> <span class="o">=</span> <span class="k">true</span><span class="p">;</span></div><div class='line' id='LC40'>			<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;table class=</span><span class="se">\&quot;</span><span class="s2">dump </span><span class="si">${</span><span class="nv">aclass</span><span class="si">}</span><span class="s2"> depth</span><span class="si">${</span><span class="nv">depth</span><span class="si">}</span><span class="se">\&quot;</span><span class="s2">&gt;</span><span class="si">$tabs</span><span class="s2">&lt;thead&gt;&lt;tr&gt;&lt;th colspan=</span><span class="se">\&quot;</span><span class="s2">2</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span> <span class="o">.</span> <span class="p">(</span><span class="nv">$label</span> <span class="o">!=</span> <span class="s1">&#39;&#39;</span> <span class="o">?</span> <span class="nv">$label</span> <span class="o">.</span> <span class="s1">&#39; - &#39;</span> <span class="o">:</span> <span class="s1">&#39;&#39;</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;array&quot;</span> <span class="o">.</span> <span class="p">(</span><span class="nv">$c</span> <span class="o">&gt;</span> <span class="m">0</span> <span class="o">?</span> <span class="s2">&quot;&quot;</span> <span class="o">:</span> <span class="s2">&quot; [empty]&quot;</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;&lt;/th&gt;&lt;/tr&gt;&lt;/thead&gt;</span><span class="si">$tabs</span><span class="s2">&lt;tbody&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC41'>			<span class="k">foreach</span> <span class="p">(</span><span class="nv">$var</span> <span class="k">as</span> <span class="nv">$index</span> <span class="o">=&gt;</span> <span class="nv">$aval</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC42'>				<span class="k">if</span> <span class="p">(</span><span class="nv">$index</span> <span class="o">===</span> <span class="s1">&#39;fw1recursionsentinel&#39;</span><span class="p">)</span></div><div class='line' id='LC43'>					<span class="k">continue</span><span class="p">;</span></div><div class='line' id='LC44'>				<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">key</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span> <span class="o">.</span> <span class="nv">$he</span><span class="p">(</span><span class="nv">$index</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;&lt;/td&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">value</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;div&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC45'>				<span class="nx">self</span><span class="o">::</span><span class="na">dump</span><span class="p">(</span><span class="nv">$aval</span><span class="p">,</span> <span class="nv">$limit</span><span class="p">,</span> <span class="s1">&#39;&#39;</span><span class="p">,</span> <span class="nv">$depth</span><span class="p">);</span></div><div class='line' id='LC46'>				<span class="k">echo</span> <span class="s2">&quot;&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC47'>				<span class="nv">$printCount</span><span class="o">++</span><span class="p">;</span></div><div class='line' id='LC48'>				<span class="k">if</span> <span class="p">((</span><span class="nv">$limit</span> <span class="o">&gt;</span> <span class="m">0</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">(</span><span class="nv">$printCount</span> <span class="o">&gt;=</span> <span class="nv">$limit</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">(</span><span class="nv">$aclass</span> <span class="o">===</span> <span class="s1">&#39;array&#39;</span><span class="p">))</span></div><div class='line' id='LC49'>					<span class="k">break</span><span class="p">;</span></div><div class='line' id='LC50'>			<span class="p">}</span></div><div class='line' id='LC51'>			<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;/tbody&gt;</span><span class="si">$tabs</span><span class="s2">&lt;/table&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC52'>			<span class="c1">// unset($var[&#39;fw1recursionsentinel&#39;]);</span></div><div class='line' id='LC53'>		<span class="p">}</span> <span class="k">elseif</span> <span class="p">(</span><span class="nb">is_string</span><span class="p">(</span><span class="nv">$var</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC54'>			<span class="k">echo</span> <span class="nv">$var</span> <span class="o">===</span> <span class="s1">&#39;&#39;</span> <span class="o">?</span> <span class="s1">&#39;[EMPTY STRING]&#39;</span> <span class="o">:</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC55'>		<span class="p">}</span> <span class="k">elseif</span> <span class="p">(</span><span class="nb">is_bool</span><span class="p">(</span><span class="nv">$var</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC56'>			<span class="k">echo</span> <span class="nv">$var</span> <span class="o">?</span> <span class="s2">&quot;TRUE&quot;</span> <span class="o">:</span> <span class="s2">&quot;FALSE&quot;</span><span class="p">;</span></div><div class='line' id='LC57'>		<span class="p">}</span> <span class="k">elseif</span> <span class="p">(</span><span class="nb">is_callable</span><span class="p">(</span><span class="nv">$var</span><span class="p">)</span> <span class="o">||</span> <span class="p">(</span><span class="nb">is_object</span><span class="p">(</span><span class="nv">$var</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="nb">is_subclass_of</span><span class="p">(</span><span class="nv">$var</span><span class="p">,</span> <span class="s1">&#39;ReflectionFunctionAbstract&#39;</span><span class="p">)))</span> <span class="p">{</span></div><div class='line' id='LC58'>			<span class="nx">self</span><span class="o">::</span><span class="na">dumpFunction</span><span class="p">(</span><span class="nv">$var</span><span class="p">,</span> <span class="nv">$tabs</span><span class="p">,</span> <span class="nv">$limit</span><span class="p">,</span> <span class="nv">$label</span><span class="p">,</span> <span class="nv">$depth</span><span class="p">);</span></div><div class='line' id='LC59'>		<span class="p">}</span> <span class="k">elseif</span> <span class="p">(</span><span class="nb">is_resource</span><span class="p">(</span><span class="nv">$var</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC60'>			<span class="k">echo</span> <span class="s2">&quot;(Resource)&quot;</span><span class="p">;</span></div><div class='line' id='LC61'>		<span class="p">}</span> <span class="k">elseif</span> <span class="p">(</span><span class="nb">is_float</span><span class="p">(</span><span class="nv">$var</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC62'>			<span class="k">echo</span> <span class="s2">&quot;(float) &quot;</span> <span class="o">.</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC63'>		<span class="p">}</span> <span class="k">elseif</span> <span class="p">(</span><span class="nb">is_int</span><span class="p">(</span><span class="nv">$var</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC64'>			<span class="k">echo</span> <span class="s2">&quot;(int) &quot;</span> <span class="o">.</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC65'>		<span class="p">}</span> <span class="k">elseif</span> <span class="p">(</span><span class="nb">is_null</span><span class="p">(</span><span class="nv">$var</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC66'>			<span class="k">echo</span> <span class="s2">&quot;NULL&quot;</span><span class="p">;</span></div><div class='line' id='LC67'>		<span class="p">}</span> <span class="k">elseif</span> <span class="p">(</span><span class="nb">is_object</span><span class="p">(</span><span class="nv">$var</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC68'>			<span class="nv">$ref</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">\ReflectionObject</span><span class="p">(</span><span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC69'>			<span class="nv">$parent</span> <span class="o">=</span> <span class="nv">$ref</span><span class="o">-&gt;</span><span class="na">getParentClass</span><span class="p">();</span></div><div class='line' id='LC70'>			<span class="nv">$interfaces</span> <span class="o">=</span> <span class="nb">implode</span><span class="p">(</span><span class="s2">&quot;&lt;br/&gt;implements &quot;</span><span class="p">,</span> <span class="nv">$ref</span><span class="o">-&gt;</span><span class="na">getInterfaceNames</span><span class="p">());</span></div><div class='line' id='LC71'>			<span class="nv">$objHash</span> <span class="o">=</span> <span class="nx">spl_object_hash</span><span class="p">(</span><span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC72'>			<span class="nv">$refHash</span> <span class="o">=</span> <span class="s1">&#39;r&#39;</span> <span class="o">.</span> <span class="nb">md5</span><span class="p">(</span><span class="nv">$ref</span><span class="p">);</span></div><div class='line' id='LC73'>			<span class="nv">$objClassName</span> <span class="o">=</span> <span class="nv">$ref</span><span class="o">-&gt;</span><span class="na">getName</span><span class="p">();</span></div><div class='line' id='LC74'>			<span class="k">if</span> <span class="p">(</span><span class="nv">$objClassName</span> <span class="o">===</span> <span class="s1">&#39;SimpleXMLElement&#39;</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC75'>				<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;table class=</span><span class="se">\&quot;</span><span class="s2">dump xml depth</span><span class="si">${</span><span class="nv">depth</span><span class="si">}</span><span class="se">\&quot;</span><span class="s2">&gt;</span><span class="si">$tabs</span><span class="s2">&lt;thead&gt;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;th colspan=</span><span class="se">\&quot;</span><span class="s2">2</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span> <span class="o">.</span> <span class="p">(</span><span class="nv">$label</span> <span class="o">!=</span> <span class="s1">&#39;&#39;</span> <span class="o">?</span> <span class="nv">$label</span> <span class="o">.</span> <span class="s1">&#39; - &#39;</span> <span class="o">:</span> <span class="s1">&#39;&#39;</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;xml element&lt;/th&gt;&lt;/tr&gt;</span><span class="si">$tabs</span><span class="s2">&lt;tbody&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC76'>				<span class="nx">self</span><span class="o">::</span><span class="na">trKeyValue</span><span class="p">(</span><span class="s1">&#39;Name&#39;</span><span class="p">,</span> <span class="nv">$var</span><span class="o">-&gt;</span><span class="na">getName</span><span class="p">());</span></div><div class='line' id='LC77'>				<span class="c1">// echo &quot;&lt;tr&gt;&lt;td class=\&quot;key\&quot;&gt;Name&lt;/td&gt;&lt;td class=\&quot;value\&quot;&gt;&quot; . htmlentities($var-&gt;getName()) . &quot;&lt;/td&gt;&lt;/tr&gt;\n&quot;;</span></div><div class='line' id='LC78'>				<span class="nv">$attribs</span> <span class="o">=</span> <span class="k">array</span><span class="p">();</span></div><div class='line' id='LC79'>				<span class="k">foreach</span> <span class="p">(</span><span class="nv">$var</span><span class="o">-&gt;</span><span class="na">attributes</span><span class="p">()</span> <span class="k">as</span> <span class="nv">$attribName</span> <span class="o">=&gt;</span> <span class="nv">$attribValue</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC80'>					<span class="nv">$attribs</span><span class="p">[</span><span class="nv">$attribName</span><span class="p">]</span> <span class="o">=</span> <span class="nv">$attribValue</span><span class="p">;</span></div><div class='line' id='LC81'>				<span class="p">}</span></div><div class='line' id='LC82'>				<span class="k">if</span> <span class="p">(</span><span class="nb">count</span><span class="p">(</span><span class="nv">$attribs</span><span class="p">)</span> <span class="o">&gt;</span> <span class="m">0</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC83'>					<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">key</span><span class="se">\&quot;</span><span class="s2">&gt;Attributes&lt;/td&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">values</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;div&gt;</span><span class="si">$tabs</span><span class="s2">&lt;table class=</span><span class="se">\&quot;</span><span class="s2">dump xml attributes</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;tbody&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC84'>					<span class="k">foreach</span> <span class="p">(</span><span class="nv">$attribs</span> <span class="k">as</span> <span class="nv">$attribName</span> <span class="o">=&gt;</span> <span class="nv">$attribValue</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC85'>						<span class="nx">self</span><span class="o">::</span><span class="na">trKeyValue</span><span class="p">(</span><span class="nv">$attribName</span><span class="p">,</span> <span class="nv">$attribValue</span><span class="p">);</span></div><div class='line' id='LC86'>					<span class="p">}</span></div><div class='line' id='LC87'>					<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;/tbody&gt;&lt;/table&gt;</span><span class="si">$tabs</span><span class="s2">&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC88'>				<span class="p">}</span></div><div class='line' id='LC89'>				<span class="nv">$xmlText</span> <span class="o">=</span> <span class="nb">trim</span><span class="p">((</span><span class="nx">string</span><span class="p">)</span> <span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC90'>				<span class="k">if</span> <span class="p">(</span><span class="nv">$xmlText</span> <span class="o">!==</span> <span class="s1">&#39;&#39;</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC91'>					<span class="nx">self</span><span class="o">::</span><span class="na">trKeyValue</span><span class="p">(</span><span class="s1">&#39;Text&#39;</span><span class="p">,</span> <span class="nv">$xmlText</span><span class="p">);</span></div><div class='line' id='LC92'>				<span class="p">}</span></div><div class='line' id='LC93'>				<span class="k">if</span> <span class="p">(</span><span class="nv">$var</span><span class="o">-&gt;</span><span class="na">count</span><span class="p">()</span> <span class="o">&gt;</span> <span class="m">0</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC94'>					<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">key</span><span class="se">\&quot;</span><span class="s2">&gt;Children&lt;/td&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">values</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;div&gt;</span><span class="si">$tabs</span><span class="s2">&lt;table class=</span><span class="se">\&quot;</span><span class="s2">dump xml children</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;tbody&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC95'>					<span class="nv">$childNum</span> <span class="o">=</span> <span class="m">0</span><span class="p">;</span></div><div class='line' id='LC96'>					<span class="k">foreach</span> <span class="p">(</span><span class="nv">$var</span><span class="o">-&gt;</span><span class="na">children</span><span class="p">()</span> <span class="k">as</span> <span class="nv">$child</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC97'>						<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">key</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span> <span class="o">.</span> <span class="nv">$childNum</span> <span class="o">.</span> <span class="s2">&quot;&lt;/td&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">value child</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;div&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC98'>						<span class="nx">self</span><span class="o">::</span><span class="na">dump</span><span class="p">(</span><span class="nv">$child</span><span class="p">,</span> <span class="nv">$limit</span><span class="p">,</span> <span class="s1">&#39;&#39;</span><span class="p">,</span> <span class="nv">$depth</span> <span class="o">+</span> <span class="m">1</span><span class="p">);</span></div><div class='line' id='LC99'>						<span class="k">echo</span> <span class="s2">&quot;&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC100'>						<span class="nv">$childNum</span><span class="o">++</span><span class="p">;</span></div><div class='line' id='LC101'>					<span class="p">}</span></div><div class='line' id='LC102'>					<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;/tbody&gt;&lt;/table&gt;</span><span class="si">$tabs</span><span class="s2">&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC103'>				<span class="p">}</span></div><div class='line' id='LC104'>			<span class="p">}</span> <span class="k">else</span> <span class="p">{</span></div><div class='line' id='LC105'>				<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;table class=</span><span class="se">\&quot;</span><span class="s2">dump object depth</span><span class="si">${</span><span class="nv">depth</span><span class="si">}</span><span class="se">\&quot;</span><span class="s2">&quot;</span> <span class="o">.</span> <span class="p">(</span><span class="nb">isset</span><span class="p">(</span><span class="nv">$seen</span><span class="p">[</span><span class="nv">$refHash</span><span class="p">])</span> <span class="o">?</span> <span class="s2">&quot;&quot;</span> <span class="o">:</span> <span class="s2">&quot;id=</span><span class="se">\&quot;</span><span class="si">$refHash</span><span class="se">\&quot;</span><span class="s2">&quot;</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;&gt;</span><span class="si">$tabs</span><span class="s2">&lt;thead&gt;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;th colspan=</span><span class="se">\&quot;</span><span class="s2">2</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span> <span class="o">.</span> <span class="p">(</span><span class="nv">$label</span> <span class="o">!=</span> <span class="s1">&#39;&#39;</span> <span class="o">?</span> <span class="nv">$label</span> <span class="o">.</span> <span class="s1">&#39; - &#39;</span> <span class="o">:</span> <span class="s1">&#39;&#39;</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;object &quot;</span> <span class="o">.</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$objClassName</span><span class="p">)</span> <span class="o">.</span> <span class="p">(</span><span class="nv">$parent</span> <span class="o">?</span> <span class="s2">&quot;&lt;br/&gt;extends &quot;</span> <span class="o">.</span><span class="nv">$parent</span><span class="o">-&gt;</span><span class="na">getName</span><span class="p">()</span> <span class="o">:</span> <span class="s2">&quot;&quot;</span><span class="p">)</span> <span class="o">.</span> <span class="p">(</span><span class="nv">$interfaces</span> <span class="o">!==</span> <span class="s1">&#39;&#39;</span> <span class="o">?</span> <span class="s2">&quot;&lt;br/&gt;implements &quot;</span> <span class="o">.</span> <span class="nv">$interfaces</span> <span class="o">:</span> <span class="s2">&quot;&quot;</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;&lt;/th&gt;&lt;/tr&gt;</span><span class="si">$tabs</span><span class="s2">&lt;tbody&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC106'>				<span class="k">if</span> <span class="p">(</span><span class="nb">isset</span><span class="p">(</span><span class="nv">$seen</span><span class="p">[</span><span class="nv">$objHash</span><span class="p">]))</span> <span class="p">{</span></div><div class='line' id='LC107'>					<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td colspan=</span><span class="se">\&quot;</span><span class="s2">2</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;a href=</span><span class="se">\&quot;</span><span class="s2">#</span><span class="si">$refHash</span><span class="se">\&quot;</span><span class="s2">&gt;[see above for details]&lt;/a&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC108'>				<span class="p">}</span> <span class="k">else</span> <span class="p">{</span></div><div class='line' id='LC109'>					<span class="nv">$seen</span><span class="p">[</span><span class="nv">$objHash</span><span class="p">]</span> <span class="o">=</span> <span class="k">TRUE</span><span class="p">;</span></div><div class='line' id='LC110'>					<span class="nv">$constants</span> <span class="o">=</span> <span class="nv">$ref</span><span class="o">-&gt;</span><span class="na">getConstants</span><span class="p">();</span></div><div class='line' id='LC111'>					<span class="k">if</span> <span class="p">(</span><span class="nb">count</span><span class="p">(</span><span class="nv">$constants</span><span class="p">)</span> <span class="o">&gt;</span> <span class="m">0</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC112'>						<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">key</span><span class="se">\&quot;</span><span class="s2">&gt;CONSTANTS&lt;/td&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">values</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;div&gt;</span><span class="si">$tabs</span><span class="s2">&lt;table class=</span><span class="se">\&quot;</span><span class="s2">dump object</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC113'>						<span class="k">foreach</span> <span class="p">(</span><span class="nv">$constants</span> <span class="k">as</span> <span class="nv">$constant</span> <span class="o">=&gt;</span> <span class="nv">$cval</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC114'>							<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">key</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span> <span class="o">.</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$constant</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;&lt;/td&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">value constant</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;div&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC115'>							<span class="nx">self</span><span class="o">::</span><span class="na">dump</span><span class="p">(</span><span class="nv">$cval</span><span class="p">,</span> <span class="nv">$limit</span><span class="p">,</span> <span class="s1">&#39;&#39;</span><span class="p">,</span> <span class="nv">$depth</span> <span class="o">+</span> <span class="m">1</span><span class="p">);</span></div><div class='line' id='LC116'>							<span class="k">echo</span> <span class="s2">&quot;&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC117'>						<span class="p">}</span></div><div class='line' id='LC118'>						<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;/table&gt;</span><span class="si">$tabs</span><span class="s2">&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC119'>					<span class="p">}</span></div><div class='line' id='LC120'>					<span class="nv">$properties</span> <span class="o">=</span> <span class="nv">$ref</span><span class="o">-&gt;</span><span class="na">getProperties</span><span class="p">();</span></div><div class='line' id='LC121'>					<span class="k">if</span> <span class="p">(</span><span class="nb">count</span><span class="p">(</span><span class="nv">$properties</span><span class="p">)</span> <span class="o">&gt;</span> <span class="m">0</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC122'>						<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">key</span><span class="se">\&quot;</span><span class="s2">&gt;PROPERTIES&lt;/td&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">values</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;div&gt;</span><span class="si">$tabs</span><span class="s2">&lt;table class=</span><span class="se">\&quot;</span><span class="s2">dump object</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC123'>						<span class="k">foreach</span> <span class="p">(</span><span class="nv">$properties</span> <span class="k">as</span> <span class="nv">$property</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC124'>							<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">key</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span> <span class="o">.</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nb">implode</span><span class="p">(</span><span class="s1">&#39; &#39;</span><span class="p">,</span> <span class="nx">\Reflection</span><span class="o">::</span><span class="na">getModifierNames</span><span class="p">(</span><span class="nv">$property</span><span class="o">-&gt;</span><span class="na">getModifiers</span><span class="p">())))</span> <span class="o">.</span> <span class="s2">&quot; &quot;</span> <span class="o">.</span> <span class="nv">$he</span><span class="p">(</span><span class="nv">$property</span><span class="o">-&gt;</span><span class="na">getName</span><span class="p">())</span> <span class="o">.</span> <span class="s2">&quot;&lt;/td&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">value property</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;div&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC125'>							<span class="nv">$wasHidden</span> <span class="o">=</span> <span class="nv">$property</span><span class="o">-&gt;</span><span class="na">isPrivate</span><span class="p">()</span> <span class="o">||</span> <span class="nv">$property</span><span class="o">-&gt;</span><span class="na">isProtected</span><span class="p">();</span></div><div class='line' id='LC126'>							<span class="nv">$property</span><span class="o">-&gt;</span><span class="na">setAccessible</span><span class="p">(</span><span class="k">TRUE</span><span class="p">);</span></div><div class='line' id='LC127'>							<span class="nv">$propVal</span> <span class="o">=</span> <span class="nv">$property</span><span class="o">-&gt;</span><span class="na">getValue</span><span class="p">(</span><span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC128'>							<span class="nx">self</span><span class="o">::</span><span class="na">dump</span><span class="p">(</span><span class="nv">$propVal</span><span class="p">,</span> <span class="nv">$limit</span><span class="p">,</span> <span class="s1">&#39;&#39;</span><span class="p">,</span> <span class="nv">$depth</span> <span class="o">+</span> <span class="m">1</span><span class="p">);</span></div><div class='line' id='LC129'>							<span class="k">if</span> <span class="p">(</span><span class="nv">$wasHidden</span><span class="p">)</span> <span class="p">{</span> <span class="nv">$property</span><span class="o">-&gt;</span><span class="na">setAccessible</span><span class="p">(</span><span class="k">FALSE</span><span class="p">);</span> <span class="p">}</span></div><div class='line' id='LC130'>							<span class="k">echo</span> <span class="s2">&quot;&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC131'>						<span class="p">}</span></div><div class='line' id='LC132'>						<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;/table&gt;</span><span class="si">$tabs</span><span class="s2">&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC133'>					<span class="p">}</span></div><div class='line' id='LC134'>					<span class="nv">$methods</span> <span class="o">=</span> <span class="nv">$ref</span><span class="o">-&gt;</span><span class="na">getMethods</span><span class="p">();</span></div><div class='line' id='LC135'>					<span class="k">if</span> <span class="p">(</span><span class="nb">count</span><span class="p">(</span><span class="nv">$methods</span><span class="p">)</span> <span class="o">&gt;</span> <span class="m">0</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC136'>						<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">key</span><span class="se">\&quot;</span><span class="s2">&gt;METHODS&lt;/td&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">values shh</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;div&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC137'>						<span class="k">if</span> <span class="p">(</span><span class="nb">isset</span><span class="p">(</span><span class="nv">$seen</span><span class="p">[</span><span class="nv">$refHash</span><span class="p">]))</span> <span class="p">{</span></div><div class='line' id='LC138'>							<span class="k">echo</span> <span class="s2">&quot;&lt;a href=</span><span class="se">\&quot;</span><span class="s2">#</span><span class="si">$refHash</span><span class="se">\&quot;</span><span class="s2">&gt;[see above for details]&lt;/a&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC139'>						<span class="p">}</span> <span class="k">else</span> <span class="p">{</span></div><div class='line' id='LC140'>							<span class="nv">$seen</span><span class="p">[</span><span class="nv">$refHash</span><span class="p">]</span> <span class="o">=</span> <span class="k">TRUE</span><span class="p">;</span></div><div class='line' id='LC141'>							<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;table class=</span><span class="se">\&quot;</span><span class="s2">dump object</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC142'>							<span class="k">foreach</span> <span class="p">(</span><span class="nv">$methods</span> <span class="k">as</span> <span class="nv">$method</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC143'>								<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">key</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span> <span class="o">.</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$method</span><span class="o">-&gt;</span><span class="na">getName</span><span class="p">())</span> <span class="o">.</span> <span class="s2">&quot;&lt;/td&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">value function</span><span class="se">\&quot;</span><span class="s2">&gt;&lt;div&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC144'>								<span class="nx">self</span><span class="o">::</span><span class="na">dumpFunction</span><span class="p">(</span><span class="nv">$method</span><span class="p">,</span> <span class="nv">$tabs</span><span class="p">,</span> <span class="nv">$limit</span><span class="p">,</span> <span class="s1">&#39;&#39;</span><span class="p">,</span> <span class="nv">$depth</span> <span class="o">+</span> <span class="m">1</span><span class="p">);</span></div><div class='line' id='LC145'>								<span class="k">echo</span> <span class="s2">&quot;&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC146'>							<span class="p">}</span></div><div class='line' id='LC147'>							<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;/table&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC148'>						<span class="p">}</span></div><div class='line' id='LC149'>						<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC150'>					<span class="p">}</span></div><div class='line' id='LC151'>				<span class="p">}</span></div><div class='line' id='LC152'>			<span class="p">}</span></div><div class='line' id='LC153'>			<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;/tbody&gt;</span><span class="si">$tabs</span><span class="s2">&lt;/table&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC154'>		<span class="p">}</span> <span class="k">elseif</span> <span class="p">(</span><span class="nb">is_numeric</span><span class="p">(</span><span class="nv">$var</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC155'>			<span class="k">echo</span>  <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC156'>		<span class="p">}</span> <span class="k">elseif</span> <span class="p">(</span><span class="nb">is_scalar</span><span class="p">(</span><span class="nv">$var</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC157'>			<span class="k">echo</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC158'>		<span class="p">}</span> <span class="k">else</span> <span class="p">{</span></div><div class='line' id='LC159'>			<span class="k">echo</span> <span class="nb">gettype</span><span class="p">(</span><span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC160'>		<span class="p">}</span></div><div class='line' id='LC161'>	<span class="p">}</span> <span class="c1">// dump</span></div><div class='line' id='LC162'><br/></div><div class='line' id='LC163'>	<span class="k">private</span> <span class="k">static</span> <span class="k">function</span> <span class="nf">dumpFunction</span><span class="p">(</span><span class="nv">$var</span><span class="p">,</span> <span class="nv">$tabs</span><span class="p">,</span> <span class="nv">$limit</span> <span class="o">=</span> <span class="m">0</span><span class="p">,</span> <span class="nv">$label</span> <span class="o">=</span> <span class="s1">&#39;&#39;</span><span class="p">,</span> <span class="nv">$depth</span> <span class="o">=</span> <span class="m">0</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC164'>		<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="nb">is_subclass_of</span><span class="p">(</span><span class="nv">$var</span><span class="p">,</span> <span class="s1">&#39;ReflectionFunctionAbstract&#39;</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC165'>			<span class="nv">$var</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">\ReflectionFunction</span><span class="p">(</span><span class="nv">$var</span><span class="p">);</span></div><div class='line' id='LC166'>		<span class="p">}</span></div><div class='line' id='LC167'>		<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;table class=</span><span class="se">\&quot;</span><span class="s2">dump function depth</span><span class="si">${</span><span class="nv">depth</span><span class="si">}</span><span class="se">\&quot;</span><span class="s2">&gt;</span><span class="si">$tabs</span><span class="s2">&lt;thead&gt;&lt;tr&gt;&lt;th&gt;&quot;</span> <span class="o">.</span> <span class="p">(</span><span class="nv">$label</span> <span class="o">!=</span> <span class="s1">&#39;&#39;</span> <span class="o">?</span> <span class="nv">$label</span> <span class="o">.</span> <span class="s1">&#39; - &#39;</span> <span class="o">:</span> <span class="s1">&#39;&#39;</span><span class="p">)</span> <span class="o">.</span> <span class="p">(</span><span class="nb">is_callable</span><span class="p">(</span><span class="k">array</span><span class="p">(</span><span class="nv">$var</span><span class="p">,</span> <span class="s1">&#39;getModifiers&#39;</span><span class="p">))</span> <span class="o">?</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nb">implode</span><span class="p">(</span><span class="s1">&#39; &#39;</span><span class="p">,</span> <span class="nx">\Reflection</span><span class="o">::</span><span class="na">getModifierNames</span><span class="p">(</span><span class="nv">$var</span><span class="o">-&gt;</span><span class="na">getModifiers</span><span class="p">())))</span> <span class="o">:</span> <span class="s1">&#39;&#39;</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot; function &quot;</span> <span class="o">.</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$var</span><span class="o">-&gt;</span><span class="na">getName</span><span class="p">())</span> <span class="o">.</span> <span class="s2">&quot;&lt;/th&gt;&lt;/tr&gt;&lt;/thead&gt;</span><span class="si">$tabs</span><span class="s2">&lt;tbody&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC168'>		<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">value</span><span class="se">\&quot;</span><span class="s2">&gt;</span><span class="si">$tabs</span><span class="s2">&lt;table class=</span><span class="se">\&quot;</span><span class="s2">dump layout</span><span class="se">\&quot;</span><span class="s2">&gt;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;th&gt;Parameters:&lt;/th&gt;&lt;td&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC169'>		<span class="nv">$params</span> <span class="o">=</span> <span class="nv">$var</span><span class="o">-&gt;</span><span class="na">getParameters</span><span class="p">();</span></div><div class='line' id='LC170'>		<span class="k">if</span> <span class="p">(</span><span class="nb">count</span><span class="p">(</span><span class="nv">$params</span><span class="p">)</span> <span class="o">&gt;</span> <span class="m">0</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC171'>			<span class="k">echo</span> <span class="s2">&quot;&lt;/td&gt;&lt;/tr&gt;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td colspan=</span><span class="se">\&quot;</span><span class="s2">2</span><span class="se">\&quot;</span><span class="s2">&gt;</span><span class="si">$tabs</span><span class="s2">&lt;table class=</span><span class="se">\&quot;</span><span class="s2">dump param</span><span class="se">\&quot;</span><span class="s2">&gt;</span><span class="si">$tabs</span><span class="s2">&lt;thead&gt;&lt;tr&gt;&lt;th&gt;Name&lt;/th&gt;&lt;th&gt;Array/Ref&lt;/th&gt;&lt;th&gt;Required&lt;/th&gt;&lt;th&gt;Default&lt;/th&gt;&lt;/tr&gt;&lt;/thead&gt;</span><span class="si">$tabs</span><span class="s2">&lt;tbody&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC172'>			<span class="k">foreach</span> <span class="p">(</span><span class="nv">$params</span> <span class="k">as</span> <span class="nv">$param</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC173'>				<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;td&gt;&quot;</span> <span class="o">.</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$param</span><span class="o">-&gt;</span><span class="na">getName</span><span class="p">())</span> <span class="o">.</span> <span class="s2">&quot;&lt;/td&gt;&lt;td&gt;&quot;</span> <span class="o">.</span> <span class="p">(</span><span class="nv">$param</span><span class="o">-&gt;</span><span class="na">isArray</span><span class="p">()</span> <span class="o">?</span> <span class="s2">&quot;Array &quot;</span> <span class="o">:</span> <span class="s2">&quot;&quot;</span><span class="p">)</span> <span class="o">.</span> <span class="p">(</span><span class="nv">$param</span><span class="o">-&gt;</span><span class="na">isPassedByReference</span><span class="p">()</span> <span class="o">?</span> <span class="s2">&quot;Reference&quot;</span> <span class="o">:</span> <span class="s2">&quot;&quot;</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;&lt;/td&gt;&lt;td&gt;&quot;</span> <span class="o">.</span> <span class="p">(</span><span class="nv">$param</span><span class="o">-&gt;</span><span class="na">isOptional</span><span class="p">()</span> <span class="o">?</span> <span class="s2">&quot;Optional&quot;</span> <span class="o">:</span> <span class="s2">&quot;Required&quot;</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;&lt;/td&gt;&lt;td&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC174'>				<span class="k">if</span> <span class="p">(</span><span class="nv">$param</span><span class="o">-&gt;</span><span class="na">isOptional</span><span class="p">())</span> <span class="p">{</span></div><div class='line' id='LC175'>					<span class="nv">$default</span> <span class="o">=</span> <span class="nv">$param</span><span class="o">-&gt;</span><span class="na">getDefaultValue</span><span class="p">();</span></div><div class='line' id='LC176'>					<span class="nx">self</span><span class="o">::</span><span class="na">dump</span><span class="p">(</span><span class="nv">$default</span><span class="p">,</span> <span class="nv">$limit</span><span class="p">,</span> <span class="nv">$label</span><span class="p">,</span> <span class="nv">$depth</span><span class="p">);</span></div><div class='line' id='LC177'>				<span class="p">}</span></div><div class='line' id='LC178'>				<span class="k">echo</span> <span class="s2">&quot;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC179'>			<span class="p">}</span></div><div class='line' id='LC180'>			<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;/tbody&gt;</span><span class="si">$tabs</span><span class="s2">&lt;/table&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC181'>		<span class="p">}</span> <span class="k">else</span> <span class="p">{</span></div><div class='line' id='LC182'>			<span class="k">echo</span> <span class="s2">&quot;none&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC183'>		<span class="p">}</span></div><div class='line' id='LC184'>		<span class="nv">$comment</span> <span class="o">=</span> <span class="nb">trim</span><span class="p">(</span><span class="nv">$var</span><span class="o">-&gt;</span><span class="na">getDocComment</span><span class="p">());</span></div><div class='line' id='LC185'>		<span class="k">if</span> <span class="p">((</span><span class="nv">$comment</span> <span class="o">!==</span> <span class="k">NULL</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">(</span><span class="nv">$comment</span> <span class="o">!==</span> <span class="s1">&#39;&#39;</span><span class="p">))</span> <span class="p">{</span></div><div class='line' id='LC186'>			<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;tr&gt;&lt;th&gt;Doc Comment:&lt;/th&gt;&lt;td&gt;&lt;kbd&gt;&quot;</span> <span class="o">.</span> <span class="nb">str_replace</span><span class="p">(</span><span class="s2">&quot;</span><span class="se">\n</span><span class="s2">&quot;</span><span class="p">,</span> <span class="s2">&quot;&lt;br/&gt;&quot;</span><span class="p">,</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$comment</span><span class="p">))</span> <span class="o">.</span> <span class="s2">&quot;&lt;/kbd&gt;&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC187'>		<span class="p">}</span></div><div class='line' id='LC188'>		<span class="k">echo</span> <span class="s2">&quot;&lt;/table&gt;</span><span class="si">$tabs</span><span class="s2">&lt;/td&gt;&lt;/tr&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC189'>		<span class="k">echo</span> <span class="s2">&quot;</span><span class="si">$tabs</span><span class="s2">&lt;/tbody&gt;</span><span class="si">$tabs</span><span class="s2">&lt;/table&gt;&quot;</span><span class="p">;</span></div><div class='line' id='LC190'>	<span class="p">}</span> <span class="c1">// dumpFunction</span></div><div class='line' id='LC191'><br/></div><div class='line' id='LC192'>	<span class="k">private</span> <span class="k">static</span> <span class="k">function</span> <span class="nf">trKeyValue</span><span class="p">(</span><span class="nv">$key</span><span class="p">,</span> <span class="nv">$value</span><span class="p">,</span> <span class="nv">$keyClass</span> <span class="o">=</span> <span class="s1">&#39;&#39;</span><span class="p">,</span> <span class="nv">$valueClass</span> <span class="o">=</span> <span class="s1">&#39;&#39;</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC193'>		<span class="k">echo</span> <span class="s2">&quot;&lt;tr&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">key </span><span class="si">${</span><span class="nv">keyClass</span><span class="si">}</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span> <span class="o">.</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$key</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;&lt;/td&gt;&lt;td class=</span><span class="se">\&quot;</span><span class="s2">value </span><span class="si">${</span><span class="nv">valueClass</span><span class="si">}</span><span class="se">\&quot;</span><span class="s2">&gt;&quot;</span> <span class="o">.</span> <span class="nb">htmlentities</span><span class="p">(</span><span class="nv">$value</span><span class="p">)</span> <span class="o">.</span> <span class="s2">&quot;&lt;/td&gt;&lt;/tr&gt;</span><span class="se">\n</span><span class="s2">&quot;</span><span class="p">;</span></div><div class='line' id='LC194'>	<span class="p">}</span> <span class="c1">// trKeyValue</span></div><div class='line' id='LC195'><br/></div><div class='line' id='LC196'>	<span class="k">private</span> <span class="k">static</span> <span class="k">function</span> <span class="nf">dumpCssJs</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC197'>		<span class="k">if</span> <span class="p">(</span><span class="nb">array_key_exists</span><span class="p">(</span><span class="s1">&#39;fw1dumpstarted&#39;</span><span class="p">,</span> <span class="nv">$_REQUEST</span><span class="p">))</span> <span class="p">{</span> <span class="k">return</span><span class="p">;</span> <span class="p">}</span></div><div class='line' id='LC198'>		<span class="nv">$_REQUEST</span><span class="p">[</span><span class="s1">&#39;fw1dumpstarted&#39;</span><span class="p">]</span> <span class="o">=</span> <span class="k">TRUE</span><span class="p">;</span></div><div class='line' id='LC199'>		<span class="k">echo</span><span class="s">&lt;&lt;&lt;DUMPCSSJS</span></div><div class='line' id='LC200'><span class="s">&lt;style type=&quot;text/css&quot;&gt;/* fw/1 dump */</span></div><div class='line' id='LC201'><span class="s">table.dump { color: black; background-color: white; font-size: xx-small; font-family: verdana,arial,helvetica,sans-serif; border-spacing: 0; border-collapse: collapse; }</span></div><div class='line' id='LC202'><span class="s">table.dump th { text-indent: -2em; padding: 0.25em 0.25em 0.25em 2.25em; color: #fff; }</span></div><div class='line' id='LC203'><span class="s">table.dump td { padding: 0.25em; }</span></div><div class='line' id='LC204'><span class="s">table.dump .key { cursor: pointer; }</span></div><div class='line' id='LC205'><span class="s">table.dump td.shh { background-color: #ddd; }</span></div><div class='line' id='LC206'><span class="s">table.dump td.shh div { display: none; }</span></div><div class='line' id='LC207'><span class="s">table.dump td.shh:before { content: &quot;...&quot;; }</span></div><div class='line' id='LC208'><span class="s">table.dump th, table.dump td { border-width: 2px; border-style: solid; border-spacing: 0; vertical-align: top; text-align: left; }</span></div><div class='line' id='LC209'><span class="s">table.dump.object, table.dump.object &gt; * &gt; tr &gt; td, table.dump.object &gt; thead &gt; tr &gt; th { border-color: #f00; }</span></div><div class='line' id='LC210'><span class="s">table.dump.object &gt; thead &gt; tr &gt; th { background-color: #f44; }</span></div><div class='line' id='LC211'><span class="s">table.dump.object &gt; tbody &gt; tr &gt; .key { background-color: #fcc; }</span></div><div class='line' id='LC212'><span class="s">table.dump.array, table.dump.array &gt; * &gt; tr &gt; td, table.dump.array &gt; thead &gt; tr &gt; th { border-color: #060; }</span></div><div class='line' id='LC213'><span class="s">table.dump.array &gt; thead &gt; tr &gt; th { background-color: #090; }</span></div><div class='line' id='LC214'><span class="s">table.dump.array &gt; tbody &gt; tr &gt; .key { background-color: #cfc; }</span></div><div class='line' id='LC215'><span class="s">table.dump.struct, table.dump.struct &gt; * &gt; tr &gt; td, table.dump.struct &gt; thead &gt; tr &gt; th { border-color: #00c; }</span></div><div class='line' id='LC216'><span class="s">table.dump.struct &gt; thead &gt; tr &gt; th { background-color: #44c; }</span></div><div class='line' id='LC217'><span class="s">table.dump.struct &gt; tbody &gt; tr &gt; .key { background-color: #cdf; }</span></div><div class='line' id='LC218'><span class="s">table.dump.xml, table.dump.xml &gt; * &gt; tr &gt; td, table.dump.xml &gt; thead &gt; tr &gt; th { border-color: #888; }</span></div><div class='line' id='LC219'><span class="s">table.dump.xml &gt; thead &gt; tr &gt; th { background-color: #aaa; }</span></div><div class='line' id='LC220'><span class="s">table.dump.xml &gt; tbody &gt; tr &gt; .key { background-color: #ddd; }</span></div><div class='line' id='LC221'><span class="s">table.dump.function, table.dump.function &gt; * &gt; tr &gt; td, table.dump.function &gt; thead &gt; tr &gt; th { border-color: #a40; }</span></div><div class='line' id='LC222'><span class="s">table.dump.function &gt; thead &gt; tr &gt; th { background-color: #c60; }</span></div><div class='line' id='LC223'><span class="s">table.dump.layout, table.dump.layout &gt; * &gt; tr &gt; td, table.dump.layout &gt; thead &gt; tr &gt; th { border-color: #fff; }</span></div><div class='line' id='LC224'><span class="s">table.dump.layout &gt; * &gt; tr &gt; th { font-style: italic; background-color: #fff; color: #000; font-weight: normal; border: none; }</span></div><div class='line' id='LC225'><span class="s">table.dump.param, table.dump.param &gt; * &gt; tr &gt; td, table.dump.param &gt; thead &gt; tr &gt; th { border-color: #ddd; }</span></div><div class='line' id='LC226'><span class="s">table.dump.param &gt; thead &gt; tr &gt; th  { background-color: #eee; color: black; font-weight: bold; }</span></div><div class='line' id='LC227'><span class="s">&lt;/style&gt;</span></div><div class='line' id='LC228'><span class="s">&lt;script type=&quot;text/javascript&quot; language=&quot;JavaScript&quot;&gt;</span></div><div class='line' id='LC229'><span class="s">(function(w,d){</span></div><div class='line' id='LC230'><span class="s">	var addEvent = function(o,t,f) {</span></div><div class='line' id='LC231'><span class="s">		if (o.addEventListener) o.addEventListener(t,f,false);</span></div><div class='line' id='LC232'><span class="s">		else if (o.attachEvent) {</span></div><div class='line' id='LC233'><span class="s">			o[&#39;e&#39; + t + f] = f;</span></div><div class='line' id='LC234'><span class="s">			o[t + f] = function() { o[&#39;e&#39; + t + f](w.event); }</span></div><div class='line' id='LC235'><span class="s">			o.attachEvent(&#39;on&#39; + t, o[t + f]);</span></div><div class='line' id='LC236'><span class="s">		}</span></div><div class='line' id='LC237'><span class="s">	}; // addEvent</span></div><div class='line' id='LC238'><span class="s">	var clickCell = function(e) {</span></div><div class='line' id='LC239'><span class="s">		var target = e.target || this;</span></div><div class='line' id='LC240'><span class="s">		var sib = target.nextSibling;</span></div><div class='line' id='LC241'><span class="s">		if (sib &amp;&amp; sib.tagName &amp;&amp; (sib.tagName.toLowerCase() === &#39;td&#39;)) {</span></div><div class='line' id='LC242'><span class="s">			if (/(^|\s)shh(\s|$)/.test(sib.className)) sib.className = sib.className.replace(/(^|\s)shh(\s|$)/, &#39; &#39;);</span></div><div class='line' id='LC243'><span class="s">			else sib.className += &#39; shh&#39;;</span></div><div class='line' id='LC244'><span class="s">		}</span></div><div class='line' id='LC245'><span class="s">		if (e &amp;&amp; e.stopPropagation) e.stopPropagation();</span></div><div class='line' id='LC246'><span class="s">		else w.event.cancelBubble = true;</span></div><div class='line' id='LC247'><span class="s">		return false;</span></div><div class='line' id='LC248'><span class="s">	}; // clickCell</span></div><div class='line' id='LC249'><span class="s">	var collapsifyDumps = function() {</span></div><div class='line' id='LC250'><span class="s">		setTimeout(function() {</span></div><div class='line' id='LC251'><span class="s">			var tables = document.getElementsByTagName(&#39;table&#39;);</span></div><div class='line' id='LC252'><span class="s">			for(var t = 0; t &lt; tables.length; t++) {</span></div><div class='line' id='LC253'><span class="s">				var table = tables[t];</span></div><div class='line' id='LC254'><span class="s">				var dumpPattern = /(^|\s)dump(\s|$)/;</span></div><div class='line' id='LC255'><span class="s">				var depthPattern = /(^|\s)depth1(\s|$)/;</span></div><div class='line' id='LC256'><span class="s">				if (! (dumpPattern.test(table.className) &amp;&amp; depthPattern.test(table.className) ))</span></div><div class='line' id='LC257'><span class="s">					continue;</span></div><div class='line' id='LC258'><span class="s">				var cells = table.getElementsByTagName(&#39;td&#39;);</span></div><div class='line' id='LC259'><span class="s">				var keyPattern = /(^|\s)key(\s|$)/;</span></div><div class='line' id='LC260'><span class="s">				var keyCount = 0;</span></div><div class='line' id='LC261'><span class="s">				for (var c = 0; c &lt; cells.length; c++) {</span></div><div class='line' id='LC262'><span class="s">					var cell = cells[c];</span></div><div class='line' id='LC263'><span class="s">					if (! (keyPattern.test(cell.className)))</span></div><div class='line' id='LC264'><span class="s">						continue;</span></div><div class='line' id='LC265'><span class="s">					addEvent(cell, &#39;click&#39;, clickCell);</span></div><div class='line' id='LC266'><span class="s">				} // for k</span></div><div class='line' id='LC267'><span class="s">			} // for t</span></div><div class='line' id='LC268'><span class="s">		}, 250);</span></div><div class='line' id='LC269'><span class="s">	}; // collapsify dumps</span></div><div class='line' id='LC270'><span class="s">	if (d.addEventListener) d.addEventListener(&quot;DOMContentLoaded&quot;, collapsifyDumps, false);</span></div><div class='line' id='LC271'><span class="s">	else d.onreadystatechange = function() { if (d.readyState === &#39;interactive&#39;) collapsifyDumps(this); };</span></div><div class='line' id='LC272'><span class="s">})(window,document);</span></div><div class='line' id='LC273'><span class="s">&lt;/script&gt;</span></div><div class='line' id='LC274'><span class="s">DUMPCSSJS;</span></div><div class='line' id='LC275'>	<span class="p">}</span> <span class="c1">// dumpCssJs</span></div><div class='line' id='LC276'><br/></div><div class='line' id='LC277'><span class="p">}</span> <span class="c1">// Class</span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div>


          </div>
        </div>
      </div>
    </div>
  

  </div>


<div class="frame frame-loading" style="display:none;">
  <img src="https://d3nwyuy0nl342s.cloudfront.net/images/modules/ajax/big_spinner_336699.gif" height="32" width="32">
</div>

    </div>
  
      
    </div>

    <div id="footer" class="clearfix">
      <div class="site">
        <div class="sponsor">
          <a href="http://www.rackspace.com" class="logo">
            <img alt="Dedicated Server" height="36" src="https://d3nwyuy0nl342s.cloudfront.net/images/modules/footer/rackspace_logo.png?v2" width="38" />
          </a>
          Powered by the <a href="http://www.rackspace.com ">Dedicated
          Servers</a> and<br/> <a href="http://www.rackspacecloud.com">Cloud
          Computing</a> of Rackspace Hosting<span>&reg;</span>
        </div>

        <ul class="links">
          <li class="blog"><a href="https://github.com/blog">Blog</a></li>
          <li><a href="/login/multipass?to=http%3A%2F%2Fsupport.github.com">Support</a></li>
          <li><a href="https://github.com/training">Training</a></li>
          <li><a href="http://jobs.github.com">Job Board</a></li>
          <li><a href="http://shop.github.com">Shop</a></li>
          <li><a href="https://github.com/contact">Contact</a></li>
          <li><a href="http://develop.github.com">API</a></li>
          <li><a href="http://status.github.com">Status</a></li>
        </ul>
        <ul class="sosueme">
          <li class="main">&copy; 2011 <span id="_rrt" title="0.07494s from fe1.rs.github.com">GitHub</span> Inc. All rights reserved.</li>
          <li><a href="/site/terms">Terms of Service</a></li>
          <li><a href="/site/privacy">Privacy</a></li>
          <li><a href="https://github.com/security">Security</a></li>
        </ul>
      </div>
    </div><!-- /#footer -->

    
      
      
        <!-- current locale:  -->
        <div class="locales">
          <div class="site">

            <ul class="choices clearfix limited-locales">
              <li><span class="current">English</span></li>
              
                  <li><a rel="nofollow" href="?locale=de">Deutsch</a></li>
              
                  <li><a rel="nofollow" href="?locale=fr">Français</a></li>
              
                  <li><a rel="nofollow" href="?locale=ja">日本語</a></li>
              
                  <li><a rel="nofollow" href="?locale=pt-BR">Português (BR)</a></li>
              
                  <li><a rel="nofollow" href="?locale=ru">Русский</a></li>
              
                  <li><a rel="nofollow" href="?locale=zh">中文</a></li>
              
              <li class="all"><a href="#" class="minibutton btn-forward js-all-locales"><span><span class="icon"></span>See all available languages</span></a></li>
            </ul>

            <div class="all-locales clearfix">
              <h3>Your current locale selection: <strong>English</strong>. Choose another?</h3>
              
              
                <ul class="choices">
                  
                      <li><a rel="nofollow" href="?locale=en">English</a></li>
                  
                      <li><a rel="nofollow" href="?locale=af">Afrikaans</a></li>
                  
                      <li><a rel="nofollow" href="?locale=ca">Català</a></li>
                  
                      <li><a rel="nofollow" href="?locale=cs">Čeština</a></li>
                  
                      <li><a rel="nofollow" href="?locale=de">Deutsch</a></li>
                  
                </ul>
              
                <ul class="choices">
                  
                      <li><a rel="nofollow" href="?locale=es">Español</a></li>
                  
                      <li><a rel="nofollow" href="?locale=fr">Français</a></li>
                  
                      <li><a rel="nofollow" href="?locale=hr">Hrvatski</a></li>
                  
                      <li><a rel="nofollow" href="?locale=hu">Magyar</a></li>
                  
                      <li><a rel="nofollow" href="?locale=id">Indonesia</a></li>
                  
                </ul>
              
                <ul class="choices">
                  
                      <li><a rel="nofollow" href="?locale=it">Italiano</a></li>
                  
                      <li><a rel="nofollow" href="?locale=ja">日本語</a></li>
                  
                      <li><a rel="nofollow" href="?locale=nl">Nederlands</a></li>
                  
                      <li><a rel="nofollow" href="?locale=no">Norsk</a></li>
                  
                      <li><a rel="nofollow" href="?locale=pl">Polski</a></li>
                  
                </ul>
              
                <ul class="choices">
                  
                      <li><a rel="nofollow" href="?locale=pt-BR">Português (BR)</a></li>
                  
                      <li><a rel="nofollow" href="?locale=ru">Русский</a></li>
                  
                      <li><a rel="nofollow" href="?locale=sr">Српски</a></li>
                  
                      <li><a rel="nofollow" href="?locale=sv">Svenska</a></li>
                  
                      <li><a rel="nofollow" href="?locale=zh">中文</a></li>
                  
                </ul>
              
            </div>

          </div>
          <div class="fade"></div>
        </div>
      
    

    <script>window._auth_token = "ab67165e78fcb9f93528eeea28be343320ac7844"</script>
    

<div id="keyboard_shortcuts_pane" style="display:none">
  <h2>Keyboard Shortcuts <small><a href="#" class="js-see-all-keyboard-shortcuts">(see all)</a></small></h2>

  <div class="columns threecols">
    <div class="column first">
      <h3>Site wide shortcuts</h3>
      <dl class="keyboard-mappings">
        <dt>s</dt>
        <dd>Focus site search</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>?</dt>
        <dd>Bring up this help dialog</dd>
      </dl>
    </div><!-- /.column.first -->

    <div class="column middle" style='display:none'>
      <h3>Commit list</h3>
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>t</dt>
        <dd>Open tree</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>p</dt>
        <dd>Open parent</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>c <em>or</em> o <em>or</em> enter</dt>
        <dd>Open commit</dd>
      </dl>
    </div><!-- /.column.first -->

    <div class="column last" style='display:none'>
      <h3>Pull request list</h3>
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>o <em>or</em> enter</dt>
        <dd>Open issue</dd>
      </dl>
    </div><!-- /.columns.last -->

  </div><!-- /.columns.equacols -->

  <div style='display:none'>
    <div class="rule"></div>

    <h3>Issues</h3>

    <div class="columns threecols">
      <div class="column first">
        <dl class="keyboard-mappings">
          <dt>j</dt>
          <dd>Move selected down</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>k</dt>
          <dd>Move selected up</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>x</dt>
          <dd>Toggle select target</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>o <em>or</em> enter</dt>
          <dd>Open issue</dd>
        </dl>
      </div><!-- /.column.first -->
      <div class="column middle">
        <dl class="keyboard-mappings">
          <dt>I</dt>
          <dd>Mark selected as read</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>U</dt>
          <dd>Mark selected as unread</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>e</dt>
          <dd>Close selected</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>y</dt>
          <dd>Remove selected from view</dd>
        </dl>
      </div><!-- /.column.middle -->
      <div class="column last">
        <dl class="keyboard-mappings">
          <dt>c</dt>
          <dd>Create issue</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>l</dt>
          <dd>Create label</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>i</dt>
          <dd>Back to inbox</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>u</dt>
          <dd>Back to issues</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>/</dt>
          <dd>Focus issues search</dd>
        </dl>
      </div>
    </div>
  </div>

  <div style='display:none'>
    <div class="rule"></div>

    <h3>Network Graph</h3>
    <div class="columns equacols">
      <div class="column first">
        <dl class="keyboard-mappings">
          <dt><span class="badmono">←</span> <em>or</em> h</dt>
          <dd>Scroll left</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt><span class="badmono">→</span> <em>or</em> l</dt>
          <dd>Scroll right</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt><span class="badmono">↑</span> <em>or</em> k</dt>
          <dd>Scroll up</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt><span class="badmono">↓</span> <em>or</em> j</dt>
          <dd>Scroll down</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>t</dt>
          <dd>Toggle visibility of head labels</dd>
        </dl>
      </div><!-- /.column.first -->
      <div class="column last">
        <dl class="keyboard-mappings">
          <dt>shift <span class="badmono">←</span> <em>or</em> shift h</dt>
          <dd>Scroll all the way left</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>shift <span class="badmono">→</span> <em>or</em> shift l</dt>
          <dd>Scroll all the way right</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>shift <span class="badmono">↑</span> <em>or</em> shift k</dt>
          <dd>Scroll all the way up</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>shift <span class="badmono">↓</span> <em>or</em> shift j</dt>
          <dd>Scroll all the way down</dd>
        </dl>
      </div><!-- /.column.last -->
    </div>
  </div>

  <div >
    <div class="rule"></div>

    <h3>Source Code Browsing</h3>
    <div class="columns threecols">
      <div class="column first">
        <dl class="keyboard-mappings">
          <dt>t</dt>
          <dd>Activates the file finder</dd>
        </dl>
        <dl class="keyboard-mappings">
          <dt>l</dt>
          <dd>Jump to line</dd>
        </dl>
      </div>
    </div>
  </div>

</div>
    

    <!--[if IE 8]>
    <script type="text/javascript" charset="utf-8">
      $(document.body).addClass("ie8")
    </script>
    <![endif]-->

    <!--[if IE 7]>
    <script type="text/javascript" charset="utf-8">
      $(document.body).addClass("ie7")
    </script>
    <![endif]-->

    
    <script type='text/javascript'></script>
    
  </body>
</html>

