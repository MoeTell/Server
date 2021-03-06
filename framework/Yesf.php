<?php
/**
 * 基本类
 * 
 * @author ShuangYa
 * @package Yesf
 * @category Base
 * @link https://www.sylingd.com/
 * @copyright Copyright (c) 2017 ShuangYa
 * @license https://yesf.sylibs.com/license
 */

namespace yesf;

use \yesf\library\Loader;
use \yesf\library\Swoole;
use \yesf\library\Dispatcher;
use \yesf\library\http\Response;

if (!defined('YESF_ROOT')) {
	define('YESF_ROOT', __DIR__ . '/');
}

class Yesf {
	/**
	 * 运行环境，需要与配置文件中同名
	 * 其中，设置为develop时，会自动打开一些调试功能
	 */
	public $environment = 'product';
	/**
	 * 基本目录
	 * 在进行路由解析时会忽略此前缀。默认为/，即根目录
	 * 一般不会有此需要，仅当程序处于网站二级目录时会用到
	 */
	protected static $baseUri = '/';
	//路由参数名称
	protected $routeParam = 'r';
	//配置
	protected $config = NULL;
	//缓存namespace
	protected static $app_namespace = NULL;
	//单例化
	protected static $_instance = NULL;
	/**
	 * 初始化
	 */
	public static function app() {
		if (self::$_instance === NULL) {
			throw new \yesf\library\exception\StartException('Yesf have not been construct yet');
		}
		return self::$_instance;
	}
	public function __construct($config) {
		$this->init();
		//swoole检查
		if (!extension_loaded('swoole') && !defined('YESF_UNIT')) {
			throw new \yesf\library\exception\ExtensionNotFoundException('Extension "Swoole" is required', '10027');
		}
		self::$_instance = $this;
		//配置
		if ((is_string($config) && is_file($config)) || is_array($config)) {
			$config = new \yesf\library\Config($config);
		} else {
			throw new \yesf\library\exception\StartException('Config can not be recognised');
		}
		$config->replace('application.dir', APP_PATH);
		$this->config = $config;
		self::$app_namespace = $config->get('application.namespace');
		Loader::addPsr4($config->get('application.namespace') . '\\model\\', APP_PATH . 'models');
		Dispatcher::setDefaultModule($config->get('application.module'));
		Response::$_tpl_auto_config = ($config->get('application.view.auto') == 1) ? TRUE : FALSE;
		Response::$_tpl_extension = ($config->has('application.view.extension') ? $config->get('application.view.extension') : 'phtml');
		//编码相关
		if (function_exists('mb_internal_encoding')) {
			mb_internal_encoding($config->get('application.charset'));
		}
		if (extension_loaded('swoole')) {
			Swoole::init();
			Swoole::initConsole();
		}
	}
	/**
	 * 将部分变量对外暴露
	 */
	public function getConfig($key = NULL) {
		if ($key === NULL) {
			return $this->config;
		} else {
			return $this->config->get($key);
		}
	}
	public function setEnvironment($env) {
		$this->environment = $env;
	}
	public static function setBaseUri($uri) {
		self::$baseUri = $uri;
	}
	public static function getBaseUri() {
		return self::$baseUri;
	}
	public static function getAppNamespace() {
		return self::$app_namespace;
	}
	/**
	 * 以下是各个过程的事件
	 */
	protected function init() {
		//注册自动加载
		if (!class_exists('yesf\\library\\Loader', FALSE)) {
			require(YESF_ROOT . 'library/Loader.php');
		}
		Loader::register();
	}
	public function bootstrap() {
		$bootstrapClass = $this->getConfig('application.bootstrap');
		if (empty($bootstrapClass)) {
			$bootstrapClass = 'Bootstrap';
		}
		$bootstrap = APP_PATH . $bootstrapClass . '.php';
		if (is_file($bootstrap)) {
			require($bootstrap);
			$bootstrapClass = new $bootstrapClass;
			if (method_exists($bootstrapClass, 'run')) {
				$bootstrapClass->run();
			}
		}
		return $this;
	}
	public function run() {
		Swoole::start();
	}
}