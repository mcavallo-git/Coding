#!/bin/sh
php -r "echo base64_encode((new Imagick('/path/to/image.png'))->__toString());";
