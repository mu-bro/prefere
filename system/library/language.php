<?php

class Language {
    private $default = 'english';
    private $directory;
    private $path = DIR_LANGUAGE;
    private $data = array();

    public function __construct($directory) {
        $this->directory = $directory;
    }

    public function get($key, $editable = true) {
        global $session, $language_zone_id;
        if (!empty($session->data["token"]) && !empty($session->data["lng_editable"]) && $language_zone_id == "customer" && $editable) {
            return "<span class=lng_etitable lng_key=" . $key . " zone=" . $language_zone_id . " lng_file=" . $session->data["last_loaded_lng_file"] . ">" . (isset($this->data[$key]) ? str_replace(array(
                '"',
                "'"
            ), "", $this->data[$key]) : $key) . "</span>";
        }
        return (isset($this->data[$key]) ? $this->data[$key] : $key);
    }

    public function load($filename, $directory = false, $editable = true) {
        global $session, $language_zone_id;

        global $session;
        $session->data["last_loaded_lng_file"] = $filename;

        if (!empty($directory)) {
            $file = $this->path . $directory . '/' . $filename . '.php';
        } else {
            $file = $this->path . $this->directory . '/' . $filename . '.php';
        }

        if (file_exists($file)) {
            $_ = array();

            require($file);

            if (!empty($session->data["token"]) && !empty($session->data["lng_editable"]) && $language_zone_id == "customer" && $editable) {
                foreach ($_ as $key => $value) {
                    $_[$key] = "<span class=lng_etitable lng_key=" . $key . " zone=" . $language_zone_id . " lng_file=" . $session->data["last_loaded_lng_file"] . ">" . $value . "</span>";
                }
            }

            $this->data = array_merge($this->data, $_);

            return $this->data;
        }

        $file = $this->path . $this->default . '/' . $filename . '.php';

        if (file_exists($file)) {
            $_ = array();

            require($file);

            if (!empty($session->data["token"]) && !empty($session->data["lng_editable"]) && $language_zone_id == "customer" && $editable) {
                foreach ($_ as $key => $value) {
                    $_[$key] = "<span class=lng_etitable lng_key=" . $key . " zone=" . $language_zone_id . " lng_file=" . $session->data["last_loaded_lng_file"] . ">" . $value . "</span>";
                }
            }

            $this->data = array_merge($this->data, $_);

            return $this->data;
        } else {
            trigger_error('Error: Could not load language ' . $filename . '!');
            exit();
        }
    }

    public function setPath($path) {
        if (!is_dir($path)) {
            trigger_error('Error: check path exists: '.$path);
            exit;
        }

        $this->path = $path;
    }

    public function load_full($filename, $loadOverwrite = true) {
        $_ = array();

        // Default
        $file = $this->path . $this->default . '/' . $filename . '.php';

        if (file_exists($file)) {
            require(modification($file));

            $this->data = array_merge($this->data, $_);

            if ($loadOverwrite) {
                $file = $this->path . $this->directory . '/' . $filename . '_.php';

                if (file_exists($file)) {
                    require(modification($file));

                    $this->data = array_merge($this->data, $_);
                }
            }
        }

        // Standard
        $file = $this->path . $this->directory . '/' . $filename . '.php';

        if (file_exists($file)) {
            require(modification($file));

            $this->data = array_merge($this->data, $_);

            if ($loadOverwrite) {
                $file = $this->path . $this->directory . '/' . $filename . '_.php';

                if (file_exists($file)) {
                    require(modification($file));

                    $this->data = array_merge($this->data, $_);
                }
            }
        }

        return $this->data;
    }
}

?>
