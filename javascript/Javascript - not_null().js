function not_null(test_not_null) {
  var return_val = undefined;
  try {
    if (test_not_null == null) {
      return_val = false;
    } else if (typeof test_not_null == 'undefined') {
      return_val = false;
    } else if (test_not_null == 0) {
      return_val = false;
    } else if (test_not_null == '') {
      return_val = false;
    } else if (test_not_null == '0000-00-00') {
      return_val = false;
    } else if (((typeof test_not_null) == 'object') && (test_not_null == 'Invalid Date') && (Object.prototype.toString.call(test_not_null) === "[object Date]")) {
      return_val = false;
    } else {
      return_val = true;
    }
  } catch (caught_error) {
    console.log("not_null error: " + caught_error.description);
  }
  return return_val;
}