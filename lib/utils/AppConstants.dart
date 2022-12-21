library constants;

const int API_ERROR_CODE = 5052;
const int API_TIMEOUT_CODE = 5053;

const String IN_PROGRESS = 'in_progress';
const String PENDING = 'pending';
const String COMPLETED = 'completed';

const String NULL = 'null';

const String FONT_LIGHT = 'GorditaLight';
const String FONT_REGULAR = 'GorditaRegular';
const String FONT_BOLD = 'GorditaBold';
const String FONT_MEDIUM = 'GorditaMedium';

const String PDF_TYPE = 'pdf_type';
const String USER_UPDATE = '_user_update';
const String DEFAULT_TOPIC_NAME = 'seat';
const String API_ERROR = '{"state": "API_ERROR"}';
const String API_TIMEOUT = '{"state": "API_TIMEOUT"}';

const int GENERAL_NOTIFICATION_ID = 101;

const int API_REQUEST_TIMEOUT = 10;
const int LOCATION_REQUEST_TIMEOUT = 15;

const String PRIMARY_COLOR_HEX = "91C9FF";
const String PRIMARY_LIGHT_COLOR_HEX = "D3E9FF";
const String PRIMARY_DARK_COLOR_HEX = "2493FE";
const String PRIMARY_ACCENT_COLOR_HEX = "FFFFFF";

const String LOWER_BERTH_HEX = "#E9C4FE";
const String MIDDLE_BERTH_HEX = "#E5B6B9";
const String UPPER_BERTH_HEX = "#B5DEE4";
const String SIDE_UPPER_BERTH_HEX = "#CBB7E2";
const String SIDE_LOWER_BERTH_HEX = "#C5D69C";

class AppConstants {
  static Map<String, bool> ONGOING_ACTIONS = <String, bool>{};
}
