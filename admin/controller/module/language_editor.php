<?php
/**
 * Language Editor
 * @author opencart-templates
 */
class ControllerModuleLanguageEditor extends Controller {	
	private $error = array(); 
	
	public function index() {
		$this->load->language('module/language_editor');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		
		if (!empty($this->request->get['filter_search'])) {
			$data['filter_search'] = $this->request->get['filter_search'];
		} else {
			$data['filter_search'] = '';
		}
		
		if (!empty($this->request->get['filter_language'])) {
			$data['language_id'] = intval($this->request->get['filter_language']);
		} else {
			$data['language_id'] = $this->config->get('config_language_id');
		}
		
		if (!empty($this->request->get['filter_admin'])) {
			$data['type'] = 'admin';
		} else {
			$data['type'] = 'catalog';
		}
		
		switch($data['type']) {
			case 'admin':
				$dir = DIR_LANGUAGE;
				break;
		
			default;
			case 'catalog':
				$dir = DIR_CATALOG . 'language/';
		}
		
		$url = '&filter_language=' . $data['language_id'];
		
		if ($data['type'] == 'admin') {
			$url .= '&filter_admin=1';
		}
				
		if ($data['filter_search']) {
			$url .= '&filter_search=' . $data['filter_search'];
		}
		
		foreach(array(
			'button_cancel',
			'button_filter',
			'text_admin',
			'text_language_files',
			'text_search',
			'heading_title'
		) as $var){
			$data[$var] = $this->language->get($var);
		}
				
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title')
		);

		$data['action'] = $this->url->link('module/language_editor', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
		
		$language = $this->model_localisation_language->getLanguage($data['language_id']);
		if (!$language || !isset($language['directory']))
			return false;
		
		$langDir = rtrim($dir . str_replace('../', '', $language['directory']), '/');
		
		$directories = glob($langDir.'/*', GLOB_ONLYDIR);
		
		natsort($directories);
		
		$data['language_files'] = array();
		$data['language_files_count'] = 0;
		
		if ($directories) {
			$i = 1;
			foreach ($directories as $directory) {
				$data['language_files'][$i] = array();
		
				$_dirs = explode('/', $directory);
				$data['language_files'][$i]['path'] = $_dirs[sizeof($_dirs)-1];
		
				$files = glob(rtrim($directory, '/') . '/*.php');
				if ($files)  {
					natsort($files);
		
					$data['language_files'][$i]['files'] = array();
		
					$ii = 1;
		
					foreach ($files as $ii => $file) {
						$basename = basename($file, ".php");
		
						if (mb_substr($basename, -1) == '_') continue;
		
						$localFile = basename(ltrim(str_replace($directory, '', $file), '/'), ".php");
		
						if ($data['filter_search']) {
							$oLanguage = new Language($language['directory']);
							$oLanguage->setPath($dir);
							$language_vars = $oLanguage->load($data['language_files'][$i]['path'].'/'.$localFile);
							if (!preg_grep('~'.$data['filter_search'].'~i', $language_vars) && !preg_grep('~'.$data['filter_search'].'~i', array_keys($language_vars))) {
								continue;
							}
						}
		
						$data['language_files'][$i]['files'][$ii] = array(
							'file' => $localFile,
							'action' => $this->url->link('module/language_editor/edit', 'token='.$this->session->data['token'] . '&file=' .$language['directory'].'/'.$data['language_files'][$i]['path'].'/'.$localFile . $url, 'SSL')
						);
		
						$data['language_files_count']++;
		
						$ii++;
					}
				}
				$i++;
			}
		}
		
		$this->document->addStyle('view/stylesheet/module/language_editor.css');
		$this->document->addScript('view/javascript/module/language_editor.js');
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('module/language_editor/files.tpl', $data));
	}

	/**
	 * Edit
	 */
	public function edit() {
		$this->load->language('module/language_editor');

		if (empty($this->request->get['file'])) {
			return false;
		}

		foreach(array(
			'button_cancel',
			'button_delete',
			'button_save',
			'text_confirm'
		) as $var) {
			$data[$var] = $this->language->get($var);
		}

		if(!empty($this->request->get['filter_admin'])){
			$data['language_type'] = 'admin';
		} else {
			$data['language_type'] = 'catalog';
		}
	
		$data['language_file'] = $this->request->get['file'];
	
		# Type
		if ($data['language_type'] == 'admin') {
			$dir = DIR_LANGUAGE;
		} else {
			$dir = DIR_CATALOG . 'language/';
		}

		list($language, $directory, $file) = explode('/', $data['language_file']);

		$url = '&file='.$data['language_file'];
		
		if($data['language_type'] == 'admin'){
			$url .= '&filter_admin=1';
		}
		
		if(!empty($this->request->get['filter_admin'])){
			$url .= '&filter_language=' . $this->request->get['filter_admin'];
		}
	
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		
		if($this->validate()){
			// Delete
			if (isset($this->request->get['action']) && $this->request->get['action'] == 'delete') {
				$file = str_replace('../', '', $dir.$language.'/'.$directory.'/'.$file.'_.php');
				
				if(file_exists($file) && is_writeable($file) && unlink($file)){
					$this->session->data['success'] = $this->language->get('text_success');
		
					$this->response->redirect($this->url->link('module/language_editor/edit', 'token='.$this->session->data['token'].$url, 'SSL'));
				}
			}
		
			// Save
			if ($this->request->server['REQUEST_METHOD'] == 'POST') {
				$result = $this->_updateLanguageFile($dir, $language, $directory, $file, $this->request->post['vars']);
		
				if (is_array($result)) {
					$this->error['warning'] = sprintf($this->language->get('error_language_permissions'), str_replace(str_replace('/system', '', DIR_SYSTEM), '', $result['language_file']));
					$data['manual'] = $result;
					$data['manual']['info'] = sprintf($this->language->get('text_language_permissions'), $result['filename'], $result['path']);
				} else {
					if ($result === true) {
						$this->session->data['success'] = $this->language->get('text_success');
					}
					sleep(3);
					$this->response->redirect($this->url->link('module/language_editor/edit', 'need_redirect=true&token='.$this->session->data['token'].$url, 'SSL'));
				}
			}
		}
		
		$this->document->setTitle($this->language->get('heading_title') . ' &raquo; ' . $data['language_file']);
					
		if (isset($this->session->data['attention'])) {
			$data['error_attention'] = $this->session->data['attention'];
			unset($this->session->data['attention']);
		} else {
			$data['error_attention'] = '';
		}
	
		if (isset($this->session->data['error'])) {
			$data['error_warning'] = $this->session->data['error'];
			unset($this->session->data['error']);
		} else {
			$data['error_warning'] = '';
		}
		
		foreach ($this->error as $key => $val) {
			$data["error_{$key}"] = $val;
		}
	
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
				
		$data['action'] = $this->url->link('module/language_editor/edit', 'token='.$this->session->data['token'] . $url, 'SSL');

		$url = '&file='.$data['language_file'];
		
		if($data['language_type'] == 'admin'){
			$url .= '&type=admin';
		}
		
		if (!isset($this->request->get['sort'])) {
			$url .= '&sort=asc';
		}
		
		$data['action_sort'] = $this->url->link('module/language_editor/edit', 'token='.$this->session->data['token'] . $url, 'SSL');
		
		$url = '';
		
		if ($data['language_type'] == 'admin') {
			$url .= '&filter_admin=1';
		}
		
		if (!empty($this->request->get['filter_language'])) {
			$url .= '&filter_language=' . $this->request->get['filter_language'];
		}
		
		if (!empty($this->request->get['filter_search'])) {
			$url .= '&filter_search=' . $this->request->get['filter_search'];
		}
				
		$data['cancel'] = $this->url->link('module/language_editor', 'token='.$this->session->data['token'] . $url, 'SSL');
				
		$data['breadcrumbs'] = array();
		
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);
		
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);
		
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/language_editor', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);
		
		$data['breadcrumbs'][] = array(
			'text' => $data['language_file']
		);
	
		$data['sort'] = '';
	
		$oLang = new Language($language);
		$oLang->setPath($dir);
	
		$vars = $oLang->load($directory.'/'.$file);
	
		if (isset($this->request->get['sort'])) {
			$data['sort'] = $this->request->get['sort'];
	
			$url .= '&sort=' . $this->request->get['sort'];
	
			ksort($vars);
		}
	
		$data['language_vars'] = array();
	
		foreach($vars as $key => $value) {
			if (isset($this->request->post['vars'][$key])) {
				$value = $this->request->post['vars'][$key];
			}
			$data['language_vars'][] = array(
				'key' => $key,
				'value' => $value,
				'hasHtml' => ($value == strip_tags(html_entity_decode($value,ENT_QUOTES,'UTF-8'))) ? false : true
			);
		}
			
		if (file_exists($dir . $language . '/' . $directory.'/'.$file . '_.php')) {
			$data['language_has_custom'] = true;
		}
		
		$this->document->addStyle('view/stylesheet/module/language_editor.css');
		$this->document->addScript('view/javascript/module/language_editor.js');
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('module/language_editor/form.tpl', $data));
	}
	
	/**
	 * Save custom language changes to new file
	 */
	private function _updateLanguageFile($dir, $language, $directory, $file, $data) {
		$path = str_replace('../', '', $dir.$language.'/'.$directory.'/');
		$file = basename($file, ".php");
		$filepath = $path.$file.'.php';
		$newfile = $path.$file.'_.php';
		$changes = array();
		$forChange = array();

		if (!file_exists($filepath)) return false;

		$oLanguage = new Language($language);
		$oLanguage->setPath($dir);
		$language_vars = $oLanguage->load($directory.'/'.$file, false);

		foreach ($language_vars as $key => $value) {
			$data[$key] = trim(str_replace(array("\r\n", "\n", "\r"), '', html_entity_decode($data[$key], ENT_QUOTES, 'UTF-8')));
			$value = trim(str_replace(array("\r\n", "\n", "\r"), '', $value));
	
			if (isset($data[$key]) && strcmp($value, $data[$key]) !== 0) {
				$changes[$key] = $data[$key];
				$forChange[$key] = $value;
			}
		}

//		if (file_exists($newfile)) {
//			$oLanguage = new Language($language);
//			$oLanguage->setPath($dir);
//			$custom_language_vars = $oLanguage->load($directory.'/'.$file.'_');
//
//			foreach ($custom_language_vars as $key => $value) {
//				$changes[$key] = $data[$key];
//			}
//		}

		if (empty($changes)) return false;
		if (is_writable($filepath) && file_exists($filepath)) {
			$content = file_get_contents($filepath);

			$content = str_replace(array("// Heading","// Text","// Entry","// Error"),'',$content);

			$content = preg_replace('/\s\s+/', ' ',$content);
			$content = str_replace(" $","\n$",$content);
			foreach($changes as $key => $value) {
				$content = $this->replaceVariable($key,$value,$forChange,$content);
//				$replace = "\$_['" . $key . "'] = '" . addslashes($value) . "';";
//				$find = "\$_['" . $key . "'] = '" . addslashes($forChange[$key]) . "';";
//				echo "find:" . $find . '<br/>';
//				echo "replace:" . $replace . '<br/><br/>';
//				$content = str_replace($find, $replace, $content);
			}
			//p($content,$changes,$filepath,$forChange );
			$fp = fopen($filepath, "w");
			fwrite($fp, $content);
			fclose($fp);
			return true;
		}
	}

	private function replaceVariable($key,$value,$forChange,$content) {
		$slash = "[\'" . '|' . '\"]';
		$find = $forChange[$key];
		$preg = '~.*[$_\[]' . "$slash($key)$slash". "]\s*=\s*$slash($find)$slash\s*;~";
		$replace = '$_["' . $key . '"] = \'' . $value . '\';';

//		$a = 'Доставка по Праге и <b>Братиславе</b>';
//		$b = 'Доставка по Праге и <b>Братиславе</b>';
//		//echo $a;die;
//		$preg = "~($a)~";
//		if(preg_match($preg, $a, $matches)) {
//		echo '11';
//		} else {
//			echo '22';
//		}
//		p($matches,$preg,$a);
//p($key,$value,$forChange);
//		preg_match($preg, $content, $matches);
//		p($preg, $content, $matches);
//die;
		if (preg_match($preg, $content, $matches)) {
			return preg_replace($preg, $replace, $content);
		}
		return $content;

	}


	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/language_editor')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

}