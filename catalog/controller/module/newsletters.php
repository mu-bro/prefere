<?php

class ControllerModuleNewsletters extends Controller {
    public function index() {
        $data = $this->load->language('module/newsletter');
        $this->load->model('module/newsletters');

        $this->model_module_newsletters->createNewsletter();

        $data['brands'] = array();

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/newsletters.tpl')) {
            return $this->load->view($this->config->get('config_template') . '/template/module/newsletters.tpl', $data);
        } else {
            return $this->load->view('default/template/module/newsletters.tpl', $data);
        }
    }

    public function news() {
         $this->load->model('module/newsletters');
        $this->load->language('module/newsletter');

        $json = array();
        if ($this->model_module_newsletters->subscribes($this->request->post)) {
            $json['success'] = $this->language->get('text_email_added');
        } else {
            $json['error'] = $this->language->get('text_email_exist');
        }
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));

    }

}
