function __CollageFileFromWeb(_fileName) {
    
    return ((string_count("http://", _fileName) > 0) || (string_count("https://", _fileName) > 0) || (string_count("www.", _fileName) > 0) || (os_browser != browser_not_a_browser));
    return false;
}