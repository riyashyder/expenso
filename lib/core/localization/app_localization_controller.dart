import 'package:flutter/material.dart';

class AppLocalizationController extends ChangeNotifier {
  static String currentAppLanguage = "en";

  static const Map<String, dynamic> _data = {
    "EXPENSO_APP_HEADER": {
      "en": "Expenso",
      "ar": "الرجاء إدخال بريد إلكتروني صالح",
      "jp": "経費",
    },

      "WELCOME_TRACK_EXPENSES_TITLE": {
        "en": "Track your expenses effortlessly",
        "ar": "تتبع نفقاتك بسهولة",
        "jp": "手軽に支出を管理しましょう"
      },

      "WELCOME_DESCRIPTION": {
        "en": "Think of this app as your smart, reliable companion for money management. It’s always with you, ready to log expenses, remind you of bills, and celebrate your financial milestones. From beginners just starting out, to budget experts looking for detailed analysis, this app adapts to your lifestyle. It’s not just about tracking—it’s about building financial freedom, step by step.",
        "ar": "فكر في هذا التطبيق كرفيق ذكي وموثوق لإدارة أموالك. فهو دائمًا معك، جاهز لتسجيل النفقات، وتذكيرك بالفواتير، والاحتفال بإنجازاتك المالية. من المبتدئين الذين يبدأون للتو إلى خبراء الميزانية الذين يبحثون عن تحليل مفصل، يتكيف هذا التطبيق مع أسلوب حياتك. الأمر لا يتعلق فقط بالتتبع – بل ببناء حرية مالية خطوة بخطوة.",
        "jp": "このアプリは、あなたのお金の管理をサポートする賢くて頼れるパートナーです。いつでも支出の記録、請求のリマインド、そして財務的な達成のサポートをしてくれます。初心者から詳細な分析を求める上級者まで、あなたのライフスタイルに合わせて適応します。単なる記録ではなく、一歩ずつ経済的自由を築くためのアプリです。"
      },

    "PROFILE_EDIT_TITLE": {
      "en": "Edit Profile",
      "jp": "プロフィール編集"
    },



    "PROFILE_CHOOSE_AVATAR": {
      "en": "Choose Avatar",
      "jp": "アバターを選択"
    },

    "PROFILE_FIRST_NAME": {
      "en": "First Name",
      "jp": "名"
    },

    "PROFILE_LAST_NAME": {
      "en": "Last Name",
      "jp": "姓"
    },

    "PROFILE_EMAIL": {
      "en": "Email",
      "jp": "メールアドレス"
    },

    "PROFILE_TIME_ZONE": {
      "en": "Time Zone",
      "jp": "タイムゾーン"
    },

    "PROFILE_LANGUAGE": {
      "en": "Language",
      "jp": "言語"
    },

    "PROFILE_CURRENCY": {
      "en": "Currency",
      "jp": "通貨"
    },

    "PROFILE_SELECT_LANGUAGE": {
      "en": "Select Language",
      "jp": "言語を選択"
    },

    "LANGUAGE_ENGLISH": {
      "en": "English",
      "jp": "英語"
    },

    "LANGUAGE_ARABIC": {
      "en": "Arabic",
      "jp": "アラビア語"
    },

    "LANGUAGE_JAPANESE": {
      "en": "Japanese",
      "jp": "日本語"
    },

    "PROFILE_SELECT_CURRENCY": {
      "en": "Select Currency",
      "jp": "通貨を選択"
    },

    "PROFILE_SEARCH_CURRENCY": {
      "en": "Search currency...",
      "jp": "通貨を検索..."
    },

    "PROFILE_SAVE_CHANGES": {
      "en": "Save Changes",
      "jp": "変更を保存"
    },

    "PROFILE_NO_CHANGES": {
      "en": "No changes to update",
      "jp": "更新する変更はありません"
    },

    "PROFILE_UPDATE_SUCCESS": {
      "en": "Profile updated successfully",
      "jp": "プロフィールが正常に更新されました"
    },

    "PROFILE_UPDATE_FAILED": {
      "en": "Update failed",
      "jp": "更新に失敗しました"
    },



    "WELCOME_GET_STARTED": {
        "en": "Get Started",
        "ar": "ابدأ الآن",
        "jp": "始める"
      },

      "WELCOME_TERMS_TEXT": {
        "en": "By continuing, you agree to our Terms of Service and Privacy Policy.",
        "ar": "من خلال المتابعة، فإنك توافق على شروط الخدمة وسياسة الخصوصية الخاصة بنا.",
        "jp": "続行すると、利用規約およびプライバシーポリシーに同意したものとみなされます。"
      },


    "EXPENSO_HEADER": {
      "en": "Welcome back! \n\nYour financial journey continues. Log in to see your progress and stay on top of your goals.!",
      "ar": "الرجاء إدخال بريد إلكتروني صالح",
      "jp": "おかえりなさい！\n\nあなたのお金の旅は続きます。ログインして進捗状況を確認し、目標達成に向けて進みましょう。",
    },
    "EXPENSO_HEADER_2": {
      "en": "Every big goal starts with a small step. Sign up now and take charge of your spending, one expense at a time.",
      "ar": "الرجاء إدخال بريد إلكتروني صالح",
      "jp": "大きな目標も小さな一歩から始まります。今すぐ登録して、一つひとつの支出を管理しましょう。",
    },
    "LOGIN_TAB": {
      "en": "Login",
      "ar": "الرجاء إدخال بريد إلكتروني صالح",
      "jp": "ログイン",
    },

    "REPORTS_FROM": {
      "en": "From",
      "ar": "من",
      "jp": "開始日"
    },

    "REPORTS_TO": {
      "en": "To",
      "ar": "إلى",
      "jp": "終了日"
    },

    "TOTAL_INCOME": {
      "en": "Total Income",
      "ar": "إجمالي الدخل",
      "jp": "総収入"
    },

    "TOTAL_EXPENSE": {
      "en": "Total Expense",
      "ar": "إجمالي المصاريف",
      "jp": "総支出"
    },

    "THIS_MONTH_REPORT": {
      "en": "This\nMonth",
      "ar": "هذا\nالشهر",
      "jp": "今月"
    },

    "WEEK": {
      "en": "Week",
      "ar": "أسبوع",
      "jp": "週"
    },

    "MONTH": {
      "en": "Month",
      "ar": "شهر",
      "jp": "月"
    },

    "YEAR": {
      "en": "Year",
      "ar": "سنة",
      "jp": "年"
    },

    "EXPENSE": {
      "en": "Expense",
      "ar": "مصروف",
      "jp": "支出"
    },

    "INCOME": {
      "en": "Income",
      "ar": "دخل",
      "jp": "収入"
    },

    "EXPENSE_BREAKDOWN": {
      "en": "Expense Breakdown",
      "ar": "تفاصيل المصروف",
      "jp": "支出内訳"
    },

    "INCOME_BREAKDOWN": {
      "en": "Income Breakdown",
      "ar": "تفاصيل الدخل",
      "jp": "収入内訳"
    },

    "MONTHLY_INCOME_EXPENSE": {
      "en": "Monthly Income vs Expense",
      "ar": "الدخل مقابل المصاريف الشهرية",
      "jp": "月間収入と支出"
    },

    "TOTAL_INCOME_AMOUNT": {
      "en": "Total Income:",
      "ar": "إجمالي الدخل:",
      "jp": "総収入："
    },

    "TOTAL_EXPENSE_AMOUNT": {
      "en": "Total Expense:",
      "ar": "إجمالي المصروف:",
      "jp": "総支出："
    },

    "LABEL_INCOME": {
      "en": "Income",
      "ar": "الدخل",
      "jp": "収入"
    },

    "LABEL_EXPENSE": {
      "en": "Expense",
      "ar": "المصروف",
      "jp": "支出"
    },

    "MONTH_JAN": { "en": "Jan", "ar": "يناير", "jp": "1月" },
    "MONTH_FEB": { "en": "Feb", "ar": "فبراير", "jp": "2月" },
    "MONTH_MAR": { "en": "Mar", "ar": "مارس", "jp": "3月" },
    "MONTH_APR": { "en": "Apr", "ar": "أبريل", "jp": "4月" },
    "MONTH_MAY": { "en": "May", "ar": "مايو", "jp": "5月" },
    "MONTH_JUN": { "en": "Jun", "ar": "يونيو", "jp": "6月" },
    "MONTH_JUL": { "en": "Jul", "ar": "يوليو", "jp": "7月" },
    "MONTH_AUG": { "en": "Aug", "ar": "أغسطس", "jp": "8月" },
    "MONTH_SEP": { "en": "Sep", "ar": "سبتمبر", "jp": "9月" },
    "MONTH_OCT": { "en": "Oct", "ar": "أكتوبر", "jp": "10月" },
    "MONTH_NOV": { "en": "Nov", "ar": "نوفمبر", "jp": "11月" },
    "MONTH_DEC": { "en": "Dec", "ar": "ديسمبر", "jp": "12月" },

    "NEW_CATEGORY_TRANS": {
      "en": "New Category",
      "jp": "新しいカテゴリ",
    },
    "CATEGORY_NAME": {
      "en": "Category Name",
      "jp": "カテゴリ名",
    },
    "CATEGORY_NAME_HINT": {
      "en": "e.g., Groceries",
      "jp": "例：食料品",
    },
    "CATEGORY_NAME_EMPTY": {
      "en": "Category name cannot be empty",
      "jp": "カテゴリ名を入力してください",
    },
    "CATEGORY_NAME_MIN_LENGTH": {
      "en": "Category name must be at least 3 letters",
      "jp": "カテゴリ名は3文字以上必要です",
    },
    "DESCRIPTION": {
      "en": "Description",
      "jp": "説明",
    },
    "DESCRIPTION_HINT": {
      "en": "e.g., Food and household shopping",
      "jp": "例：食品や家庭用品の買い物",
    },
    "CATEGORY_TYPE": {
      "en": "Category Type",
      "jp": "カテゴリタイプ",
    },
    "SELECT_CATEGORY_TYPE": {
      "en": "Select Category Type",
      "jp": "カテゴリタイプを選択",
    },
    "CHOOSE_ICON": {
      "en": "Choose an Icon",
      "jp": "アイコンを選択",
    },
    "CREATE_CATEGORY": {
      "en": "Create Category",
      "jp": "カテゴリを作成",
    },


    "RESET_PASSWORD": {
      "en": "Reset Password",
      "jp": "パスワードをリセット"
    },
    "RESET_OLD_PASSWORD": {
      "en": "Old Password",
      "jp": "現在のパスワード"
    },
    "RESET_NEW_PASSWORD": {
      "en": "New Password",
      "jp": "新しいパスワード"
    },
    "UPDATE_PASSWORD": {
      "en": "Update Password",
      "jp": "パスワードを更新"
    },
    "ERR_ENTER_OLD_PASSWORD": {
      "en": "Enter old password",
      "jp": "現在のパスワードを入力してください"
    },
    "ERR_ENTER_NEW_PASSWORD": {
      "en": "Enter new password",
      "jp": "新しいパスワードを入力してください"
    },
    "ERR_PASSWORD_LENGTH": {
      "en": "Password must be at least 6 characters",
      "jp": "パスワードは6文字以上である必要があります"
    },


    "TRANS_FILTER_BY_DATE": {
      "en": "Filter by Date",
      "ar": "تصفية حسب التاريخ",
      "jp": "日付でフィルター"
    },
    "TRANS_START_DATE": {
      "en": "Start Date",
      "ar": "تاريخ البدء",
      "jp": "開始日"
    },
    "TRANS_END_DATE": {
      "en": "End Date",
      "ar": "終了日",
      "jp": "終了日"
    },
    "TRANS_SELECT_DATE": {
      "en": "Select date",
      "ar": "اختر التاريخ",
      "jp": "日付を選択"
    },
    "TRANS_CLEAR": {
      "en": "Clear",
      "ar": "مسح",
      "jp": "クリア"
    },
    "TRANS_APPLY": {
      "en": "Apply",
      "ar": "تطبيق",
      "jp": "適用"
    },
    "TRANS_END_DATE_ERROR": {
      "en": "End date cannot be before start date",
      "ar": "لا يمكن أن يكون تاريخ الانتهاء قبل تاريخ البدء",
      "jp": "終了日は開始日より前にできません"
    },
    "TRANS_INCOME": {
      "en": "Income",
      "ar": "الدخل",
      "jp": "収入"
    },
    "TRANS_INCOME_SUB": {
      "en": "INCOME",
      "ar": "الدخل",
      "jp": "収入"
    },
    "TRANS_EXPENSE": {
      "en": "EXPENSE",
      "ar": "المصروفات",
      "jp": "支出"
    },

    "TRANS_EXPENSES": {
      "en": "Expenses",
      "ar": "المصروفات",
      "jp": "支出"
    },
    "TRANS_NET": {
      "en": "Net",
      "ar": "صافي",
      "jp": "合計"
    },
    "TRANS_TAB_ALL": {
      "en": "All",
      "ar": "الكل",
      "jp": "すべて"
    },
    "TRANS_TAB_INCOME": {
      "en": "Income",
      "ar": "الدخل",
      "jp": "収入"
    },
    "TRANS_TAB_EXPENSES": {
      "en": "Expenses",
      "ar": "المصروفات",
      "jp": "支出"
    },
    "TRANS_FILTER_TRANSACTIONS": {
      "en": "Filter Transactions",
      "ar": "تصفية المعاملات",
      "jp": "取引をフィルター"
    },
    "TRANS_ADD_TRANSACTION": {
      "en": "Add Transaction",
      "ar": "إضافة معاملة",
      "jp": "取引を追加"
    },
    "TRANS_AMOUNT": {
      "en": "Amount",
      "ar": "المبلغ",
      "jp": "金額"
    },
    "TRANS_ENTER_AMOUNT": {
      "en": "Enter amount",
      "ar": "أدخل المبلغ",
      "jp": "金額を入力してください"
    },
    "TRANS_ENTER_VALID_NUMBER": {
      "en": "Enter valid number",
      "ar": "أدخل رقمًا صالحًا",
      "jp": "有効な数字を入力してください"
    },
    "TRANS_CATEGORY": {
      "en": "Category",
      "ar": "الفئة",
      "jp": "カテゴリー"
    },
    "TRANS_ENTER_CATEGORY": {
      "en": "Enter category",
      "ar": "أدخل الفئة",
      "jp": "カテゴリーを入力してください"
    },
    "SELECT_CATEGORY": {
      "en": "Select a category",
      "ar": "اختر فئة",
      "ja": "カテゴリを選択"
    },
    "LOADING_CATEGORIES": {
      "en": "Loading categories…",
      "ar": "جارٍ تحميل الفئات…",
      "ja": "カテゴリを読み込み中…"
    },
    "TRANS_TRANSACTION_TYPE": {
      "en": "Transaction Type",
      "ar": "نوع المعاملة",
      "jp": "取引タイプ"
    },
    "TRANS_TYPE_INCOME": {
      "en": "Income",
      "ar": "دخل",
      "jp": "収入"
    },
    "TRANS_TYPE_EXPENSE": {
      "en": "Expense",
      "ar": "مصروف",
      "jp": "支出"
    },
    "TRANS_DATE": {
      "en": "Date",
      "ar": "التاريخ",
      "jp": "日付"
    },
    "TRANS_CREATE_TRANSACTION": {
      "en": "Create Transaction",
      "ar": "إنشاء معاملة",
      "jp": "取引を作成"
    },
    "TRANS_SUCCESS_TRANSACTION_CREATED": {
      "en": "Transaction created successfully!",
      "ar": "تم إنشاء المعاملة بنجاح!",
      "jp": "取引が正常に作成されました！"
    },

    "CATEGORIES": {
      "en": "Categories",
      "ar": "الفئات",
      "jp": "カテゴリー"
    },
    "NEW_CATEGORY": {
      "en": "New",
      "ar": "جديد",
      "jp": "新規"
    },
    "EDIT_CATEGORY": {
      "en": "Edit Category",
      "ar": "تعديل الفئة",
      "jp": "カテゴリを編集"
    },
    "DELETE_CATEGORY": {
      "en": "Delete Category?",
      "ar": "حذف الفئة؟",
      "jp": "カテゴリを削除しますか？"
    },
    "DELETE_WARNING": {
      "en": "This action cannot be undone.",
      "ar": "لا يمكن التراجع عن هذا الإجراء.",
      "jp": "この操作は元に戻せません。"
    },
    "BTN_CANCEL": {
      "en": "Cancel",
      "ar": "إلغاء",
      "jp": "キャンセル"
    },
    "BTN_DELETE": {
      "en": "Delete",
      "ar": "حذف",
      "jp": "削除"
    },
    "BTN_SAVE": {
      "en": "Save",
      "ar": "حفظ",
      "jp": "保存"
    },
    "ENTER_CATEGORY_NAME": {
      "en": "Enter category name",
      "ar": "أدخل اسم الفئة",
      "jp": "カテゴリ名を入力"
    },
    "ENTER_DESCRIPTION": {
      "en": "Enter description",
      "ar": "أدخل الوصف",
      "jp": "説明を入力"
    },
    "CATEGORY_CREATED": {
      "en": "Category created successfully!",
      "ar": "تم إنشاء الفئة بنجاح!",
      "jp": "カテゴリが正常に作成されました！"
    },
    "CATEGORY_UPDATED": {
      "en": "Category updated successfully!",
      "ar": "تم تحديث الفئة بنجاح!",
      "jp": "カテゴリが正常に更新されました！"
    },
    "CATEGORY_DELETED": {
      "en": "Category deleted successfully!",
      "ar": "تم حذف الفئة بنجاح!",
      "jp": "カテゴリが正常に削除されました！"
    },

    "SETTINGS_SCREEN": {
      "en": "Settings",
      "ar": "الإعدادات",
      "jp": "設定"
    },

    "PREFERENCES": {
      "en": "Preferences",
      "ar": "التفضيلات",
      "jp": "設定"
    },

    "ACCOUNT": {
      "en": "Account",
      "ar": "الحساب",
      "jp": "アカウント"
    },

    "PRIVACY": {
      "en": "Privacy",
      "ar": "الخصوصية",
      "jp": "プライバシー"
    },

    "CONFIRM_LOGOUT": {
      "en": "Confirm Logout",
      "ar": "تأكيد تسجيل الخروج",
      "jp": "ログアウトの確認"
    },

    "LOGOUT_MESSAGE": {
      "en": "Are you sure you want to log out?",
      "ar": "هل أنت متأكد أنك تريد تسجيل الخروج؟",
      "jp": "ログアウトしてもよろしいですか？"
    },

    "BTN_CANCEL_SETTINGS": {
      "en": "Cancel",
      "ar": "إلغاء",
      "jp": "キャンセル"
    },

    "BTN_LOGOUT_SETTING": {
      "en": "Logout",
      "ar": "تسجيل الخروج",
      "jp": "ログアウト"
    },


    "PRE_THEME": {
      "en": "Theme",
      "ar": "السمة",
      "jp": "テーマ"
    },
    "PRE_THEME_SUBTITLE": {
      "en": "Customize the app’s appearance",
      "ar": "تخصيص مظهر التطبيق",
      "jp": "アプリの外観をカスタマイズ"
    },
    "PRE_THEME_TRAILING": {
      "en": "System",
      "ar": "النظام",
      "jp": "システム"
    },

    "PRE_CURRENCY": {
      "en": "Currency",
      "ar": "العملة",
      "jp": "通貨"
    },
    "PRE_CURRENCY_SUBTITLE": {
      "en": "Set your preferred currency",
      "ar": "عيّن العملة المفضلة لديك",
      "jp": "希望の通貨を設定"
    },
    "PRE_CURRENCY_TRAILING": {
      "en": "USD",
      "ar": "دولار أمريكي",
      "jp": "USD"
    },

    "PRE_LANGUAGE": {
      "en": "Language",
      "ar": "اللغة",
      "jp": "言語"
    },
    "PRE_LANGUAGE_SUBTITLE": {
      "en": "Choose your preferred language",
      "ar": "اختر لغتك المفضلة",
      "jp": "言語を選択"
    },
    "PRE_LANGUAGE_TRAILING": {
      "en": "English",
      "ar": "الإنجليزية",
      "jp": "英語"
    },

    "PRE_PROFILE": {
      "en": "Profile",
      "ar": "الملف الشخصي",
      "jp": "プロフィール"
    },

    "PRE_SECURITY": {
      "en": "Security",
      "ar": "الأمان",
      "jp": "セキュリティ"
    },

    "PRE_NOTIFICATIONS": {
      "en": "Notifications",
      "ar": "الإشعارات",
      "jp": "通知"
    },

    "PRE_LOGOUT": {
      "en": "Logout",
      "ar": "تسجيل الخروج",
      "jp": "ログアウト"
    },

    "PRE_TERMS_OF_SERVICE": {
      "en": "Terms of Service",
      "ar": "شروط الخدمة",
      "jp": "利用規約"
    },
    "PRE_PRIVACY_POLICY": {
      "en": "Privacy Policy",
      "ar": "سياسة الخصوصية",
      "jp": "プライバシーポリシー"
    },
    "PRE_CONTACT_US": {
      "en": "Contact Us",
      "ar": "اتصل بنا",
      "jp": "お問い合わせ"
    },

    "EXPORT_DATA_TITLE": {
      "en": "Export Data",
      "ar": "تصدير البيانات",
      "jp": "データをエクスポート",
    },

    "DATE_RANGE_EXPORT": {
      "en": "Date Range",
      "ar": "نطاق التاريخ",
      "jp": "日付範囲",
    },

    "FROM_DATE": {
      "en": "From",
      "ar": "من",
      "jp": "開始日",
    },

    "TO_DATE": {
      "en": "To",
      "ar": "إلى",
      "jp": "終了日",
    },

    "FILE_FORMAT": {
      "en": "File Format",
      "ar": "تنسيق الملف",
      "jp": "ファイル形式",
    },

    "CSV": {
      "en": "CSV",
      "ar": "CSV",
      "jp": "CSV",
    },

    "PDF": {
      "en": "PDF",
      "ar": "PDF",
      "jp": "PDF",
    },

    "EXPORT_BTN": {
      "en": "Export",
      "ar": "تصدير",
      "jp": "エクスポート",
    },

    "PRE_SETTINGS_THEME": {
      "en": "Theme",
      "ar": "السمة",
      "jp": "テーマ",
    },

    "PRE_SETTINGS_THEME_SUB": {
      "en": "Customize the app’s appearance",
      "ar": "خصص مظهر التطبيق",
      "jp": "アプリの外観をカスタマイズ",
    },

    "PRE_SETTINGS_THEME_TRAILING": {
      "en": "System",
      "ar": "النظام",
      "jp": "システム",
    },

    "PRE_SETTINGS_CURRENCY": {
      "en": "Currency",
      "ar": "العملة",
      "jp": "通貨",
    },

    "PRE_SETTINGS_CURRENCY_SUB": {
      "en": "Set your preferred currency",
      "ar": "حدد عملتك المفضلة",
      "jp": "希望の通貨を設定",
    },

    "PRE_SETTINGS_CURRENCY_TRAILING": {
      "en": "USD",
      "ar": "دولار",
      "jp": "USD",
    },

    "PRE_SETTINGS_LANGUAGE": {
      "en": "Language",
      "ar": "اللغة",
      "jp": "言語",
    },

    "PRE_SETTINGS_LANGUAGE_SUB": {
      "en": "Choose your preferred language",
      "ar": "اختر لغتك المفضلة",
      "jp": "希望の言語を選択",
    },

    "PRE_SETTINGS_LANGUAGE_TRAILING": {
      "en": "English",
      "ar": "الإنجليزية",
      "jp": "英語",
    },
    "PRE_SETTINGS_PROFILE": {
      "en": "Profile",
      "ar": "الملف الشخصي",
      "jp": "プロフィール",
    },

    "PRE_SETTINGS_SECURITY": {
      "en": "Security",
      "ar": "الأمان",
      "jp": "セキュリティ",
    },

    "PRE_SETTINGS_NOTIFICATIONS": {
      "en": "Notifications",
      "ar": "الإشعارات",
      "jp": "通知",
    },

    "PRE_SETTINGS_LOGOUT": {
      "en": "Logout",
      "ar": "تسجيل الخروج",
      "jp": "ログアウト",
    },
    "PRE_SETTINGS_TERMS": {
      "en": "Terms of Service",
      "ar": "شروط الخدمة",
      "jp": "利用規約",
    },

    "PRE_SETTINGS_PRIVACY_POLICY": {
      "en": "Privacy Policy",
      "ar": "سياسة الخصوصية",
      "jp": "プライバシーポリシー",
    },

    "PRE_SETTINGS_CONTACT_US": {
      "en": "Contact Us",
      "ar": "اتصل بنا",
      "jp": "お問い合わせ",
    },


    "SELECT_DATE": {
      "en": "Select Date",
      "ar": "اختر التاريخ",
      "jp": "日付を選択",
    },


    "LOGOUT_SUCCESS": {
      "en": "User logged out successfully",
      "ar": "تم تسجيل خروج المستخدم بنجاح",
      "jp": "ログアウトしました"
    },

    "SWITCH_NOTIFICATIONS": {
      "en": "Notifications",
      "ar": "الإشعارات",
      "jp": "通知"
    },

    "SETTINGS_LANGUAGE": {
      "en": "Language",
      "ar": "اللغة",
      "jp": "言語"
    },

    "SETTINGS_THEME": {
      "en": "Theme",
      "ar": "المظهر",
      "jp": "テーマ"
    },

    "SETTINGS_ACCOUNT_SECURITY": {
      "en": "Account Security",
      "ar": "أمان الحساب",
      "jp": "アカウントのセキュリティ"
    },

    "SETTINGS_PRIVACY_POLICY": {
      "en": "Privacy Policy",
      "ar": "سياسة الخصوصية",
      "jp": "プライバシーポリシー"
    },

    "SETTINGS_TERMS": {
      "en": "Terms & Conditions",
      "ar": "الشروط والأحكام",
      "jp": "利用規約"
    },

    "REGISTER_NAME": {
      "en": "First Name",
      "ar": "الاسم الأول",
      "jp": "名"
    },
    "REGISTER_FIRST_NAME": {
      "en": "First name is required",
      "ar": "الاسم الأول مطلوب",
      "jp": "名は必須です"
    },
    "REGISTER_LAST_NAME": {
      "en": "First Name",
    },
    "REGISTER_EMAIL_ID": {
      "en": "First Name",
    },
    "REGISTER_PASSWORD": {
      "en": "First Name",
    },
    "REGISTER_CONFIRM_PASSWORD": {
      "en": "First Name",
    },
    "REGISTER_TAB": {
      "en": "Register",
      "ar": "الرجاء إدخال بريد إلكتروني صالح",
      "jp": "登録する",
    },
    "LOGIN_EMAIL_ERROR": {
      "en": "Please enter a valid email",
      "ar": "الرجاء إدخال بريد إلكتروني صالح",
      "jp": "有効なメールアドレスを入力してください",
    },
    "header": {"en": "Welcome", "ar": "مرحباً"},
    "welcomeText": {
      "en":
      "We’re excited to have you onboard! Streamline shop management, oversee sales, and drive success with ease",
      "ar":
      "نحن متحمسون لوجودك على متن الطائرة! قم بتبسيط إدارة المتجر والإشراف على المبيعات وتحقيق النجاح بسهولة",
    },
    "elevateButton": {"en": "Continue", "ar": "يكمل"},
    "APPROVE": {"en": "Approve", "ar": "يعتمد"},
    "LOGIN_HEADER": {
      "en": "Try your chance to change your life!!",
      "ar": "جرب حظك لتغير حياتك!!",
    },
    "PLAY_AND_WIN": {
      "en": "Join us! Play and Win to Seize the Reward!!",
      "ar": "انضم إلينا! العب واربح لتحصل على الجائزة!!",
    },
    "LOGIN_EMAIL": {"en": "E-mail ID", "ar": "معرف البريد الإلكتروني","jp": "メールID",},
    "LOGIN_PASSWORD": {"en": "Password", "ar": "كلمة المرور","jp":"パスワード"},
    "LOGIN_REMEMBER": {"en": "Remember me", "ar": "تذكرنى"},
    "LOGIN_FORGOT_PASS": {"en": "Forgot Password?", "ar": "هل نسيت كلمة السر؟","jp":"パスワードをお忘れですか？"},
    "LOGIN_BUTTON_LOADING": {
      "en": "Loading...",
      "ar": "تحميل...",
      "jp": "読み込み中..."
    },
    "LOGIN_BUTTON": {
      "en": "Login",
      "ar": "تسجيل الدخول",
      "jp": "ログイン"
    },
    "HOME": {"en": "Home", "ar": "الصفحة الرئيسية"},
    "RAFFLE": {"en": "Raffle", "ar": "السحب"},
    "MENU": {"en": "Menu", "ar": "القائمة"},
    "OTP_CONFIRM_LABEL": {"en": "Confirmation", "ar": "تأكيد"},
    "OTP_SUB_HEADER_LABEL": {
      "en": "Enter the Verification Code sent to",
      "ar": "أدخل رمز التحقق المرسل إليه",
    },
    "OTP_WITHIN_LABEL": {
      "en": "Please enter the OTP within ",
      "ar": "الرجاء إدخال كلمة مرور لمرة واحدة في الداخل ",
    },
    "DID_NT_RECEIVE_CODE": {
      "en": "Didn't receive the code yet?",
      "ar": "لم تستلم الرمز بعد؟",
    },
    "RESENT_OTP": {
      "en": "Resend OTP",
      "ar": "إعادة إرسال كلمة المرور لمرة واحدة",
    },
    "RESENT_VERIFYING": {"en": "Verifying...", "ar": "جارٍ التحقق..."},
    "RESENT_VERIFY": {"en": "verify", "ar": "يؤكد"},
    "FORGOT_PASS": {"en": "Forgot Password?", "ar": "هل نسيت كلمة السر؟"},
    "PASSWORD_ERROR": {
      "en": "Password cannot be empty",
      "ar": "لا يمكن أن تكون كلمة المرور فارغة",
    },
    "PASSWORD_VALIDATION": {
      "en": "Password must be at least 8 characters long",
      "ar": "يجب أن تتكون كلمة المرور من 8 أحرف على الأقل",
    },
    "CONFIRM_PASSWORD_ERROR": {
      "en": "Confirm Password cannot be empty",
      "ar": "تأكيد كلمة المرور لا يمكن أن يكون فارغاً",
    },
    "PASSWORD_NOT_MATCH": {
      "en": "Passwords do not match",
      "ar": "كلمات المرور غير متطابقة",
      "jp": "パスワードが一致しません"
    },
    "FORGOT_PASSWORD_ERROR": {
      "en": "Please enter a valid email",
      "ar": "الرجاء إدخال بريد إلكتروني صالح",
    },
    "FORGOT_PASS_SUB_HEADER": {
      "en":
      "Enter your registered email address. We'll send you a code to help you regain the access.",
      "ar":
      "أدخل عنوان بريدك الإلكتروني المسجل. سنرسل إليك رمزًا لمساعدتك في استعادة إمكانية الوصول.",
    },
    "FORGOT_PASSWORD_LABEL": {
      "en": "Registered Email ID",
      "ar": "معرف البريد الإلكتروني المسجل",
    },
    "LOADING_LABEL": {"en": "Loading...", "ar": "تحميل"},
    "CONTINUE_LABEL": {"en": "Continue", "ar": "يكمل"},
    "MISSING_OTP_TIME": {
      "en": "OTP validity time is missing.",
      "ar": "وقت صلاحية OTP مفقود.",
    },
    "RESET_PASSWORD_HEADER": {
      "en": "Reset Password",
      "ar": "إعادة تعيين كلمة المرور",
    },
    "RESET_PASSWORD_SUB_HEADER": {
      "en":
      "Your new password must be different from the previously used ones.",
      "ar": "يجب أن تكون كلمة المرور الجديدة مختلفة عن تلك المستخدمة سابقًا.",
    },
    "PASSWORD_LABEL": {"en": "Password", "ar": "كلمة المرور"},
    "CONFIRM_PASSWORD_LABEL": {
      "en": "Confirm Password",
      "ar": "تأكيد كلمة المرور",
      "jp": "パスワードを確認"
    },
    "CONFIRM_PASSWORD_SUBMITTING": {"en": "Submitting", "ar": "تقديم"},
    "CONFIRM_PASSWORD_SUBMIT": {"en": "Submit", "ar": "يُقدِّم"},
    "PASSWORD_SUCCESS_HEADER": {
      "en": "Your password has been reset!",
      "ar": "لقد تم إعادة تعيين كلمة المرور الخاصة بك!",
    },
    "PASSWORD_SUCCESS_SUB_HEADER": {
      "en": "Your account is secure. Jump back into your world of fortunes.",
      "ar": "حسابك آمن. القفز مرة أخرى إلى عالم الثروات الخاص بك.",
    },
    "PASSWORD_SUCCESS_CONTINUE": {
      "en": "Log in to Continue",
      "ar": "قم بتسجيل الدخول للمتابعة",
    },

    "CHANGEREQUEST_DESCP": {
      "en":
      "Track all change requests and their statuses. Review, approve, or reject requests as needed.",
      "ar":
      "تتبع جميع طلبات التغيير وحالاتها. مراجعة الطلبات أو الموافقة عليها أو رفضها حسب الحاجة.",
    },
    "BILLING_PAYMENTS__DESCP": {
      "en":
      "Easily track your bills, adjustments history, and make secure payments.",
      "ar": "يمكنك بسهولة تتبع فواتيرك وسجل التعديلات وإجراء دفعات آمنة.",
    },
    "SHEET_APPLY_BTN": {"en": "Apply", "ar": "يتقدم"},
    "SHEET_CLEAR_ALL_BTN": {"en": "Clear all", "ar": "مسح الكل"},
    "BILLING_HISTORY_DESCP": {
      "en": "Track payment status, dues, and billing history effortlessly.",
      "ar": "تتبع حالة الدفع والمستحقات وتاريخ الفواتير دون عناء.",
    },
    "BILLING_TRANSACTION_DESCP": {
      "en":
      "Create and manage transactions. Edit transactions for any changes required.",
      "ar": "إنشاء وإدارة المعاملات. تحرير المعاملات لأية تغييرات مطلوبة.",
    },
    "DATE_SMALL": {"en": "Date", "ar": "تاريخ"},
    "NEW_VALUE_SMALL": {"en": "New Value", "ar": "قيمة جديدة"},
    "EXISTING_VALUE_SMALL": {"en": "Existing Value", "ar": "القيمة الحالية"},
    "IN_REVIEW": {"en": "In Review", "ar": "في المراجعة"},
    "STATUS": {"en": 'Status', "ar": "حالة"},
    "UPDATED_ON": {"en": 'Updated On', "ar": "تم التحديث على"},
    "NUMBER_OF_SHOPS": {"en": "Number of Shops", "ar": "عدد المتاجر"},
    "TOTAL_REVENUE": {"en": "Total Revenue", "ar": "إجمالي الإيرادات"},
    "BILLED_AMOUNT": {"en": "Billed Amount", "ar": "المبلغ المفوتر"},
    "PURCHASE_VALUE": {"en": "Purchase Value", "ar": "قيمة الشراء"},
    "JACKPOT_ENTRIES": {
      "en": "Jackpot Entries",
      "ar": "مشاركات الجائزة الكبرى",
    },
    "CHANGE_REQUESTS": {"en": "Change Requests", "ar": "طلبات التغيير"},
    "THIS_MONTH": {"en": "This Month", "ar": "هذا الشهر"},
    "ALL_TIME": {"en": "All Time", "ar": "كل الوقت"},
    "FROM_LAST_WEEK": {"en": "   From Last Week", "ar": "من الأسبوع الماضي  "},
    "REVENUE": {"en": "Revenue", "ar": "الإيرادات"},
    "TOP_SALES_REP": {"en": "Top Sales Rep", "ar": "أفضل مندوب مبيعات"},
    "TOP_REVENUE_SHOPS": {
      "en": "Top Revenue Shops",
      "ar": "أعلى المتاجر إيرادًا",
    },
    "SOMETHING_WENT_WRONG": {
      "en": "Something went wrong!",
      "ar": "حدث خطأ ما!",
    },
    "PULL_TO_REFRESH": {"en": "Pull to Refresh", "ar": "اسحب للتحديث"},
    "AED": {"en": "AED", "ar": "درهم"},
    "LKR": {"en": "LKR", "ar": "روبية سريلانكية"},
    "MON": {"en": "Mon", "ar": "الاثنين"},
    "TUE": {"en": "Tue", "ar": "الثلاثاء"},
    "WED": {"en": "Wed", "ar": "الأربعاء"},
    "THU": {"en": "Thu", "ar": "الخميس"},
    "FRI": {"en": "Fri", "ar": "الجمعة"},
    "SAT": {"en": "Sat", "ar": "السبت"},
    "SUN": {"en": "Sun", "ar": "الأحد"},
    "NO_DATA_AVAILABLE": {"en": "No data available !", "ar": "لا توجد بيانات"},
    "BILLING_AND_PAYMENTS": {
      "en": "Billing and Payments",
      "ar": "الفوترة والمدفوعات",
    },
    "SEARCH_BY_EMAIL": {
      "en": "Search by email",
      "ar": "البحث بالبريد الإلكتروني",
    },
    "MIN_VALUE": {"en": "Min value", "ar": "القيمة الدنيا"},
    "MAX_VALUE": {"en": "Max value", "ar": "القيمة القصوى"},
    "TOTAL_PAID": {"en": "Total Paid", "ar": "إجمالي المدفوع"},
    "TOTAL_DUE": {"en": "Total Due", "ar": "إجمالي المستحق"},
    "FILTERS": {"en": "Filters", "ar": "الفلاتر"},
    "SHOP_NAME": {"en": "Shop Name", "ar": "اسم المتجر"},
    "AREA": {"en": "Area", "ar": "المنطقة"},
    "TOTAL_BILLED": {"en": "Total Billed", "ar": "إجمالي الفواتير"},
    "ONBOARDED_DATE": {"en": "Onboarded Date", "ar": "تاريخ الانضمام"},
    "SHOP_DETAILS": {"en": "Shop Details", "ar": "تفاصيل المتجر"},
    "BILL_HISTORY": {"en": "Bill History", "ar": "سجل الفواتير"},
    "ENTER": {"en": "Enter", "ar": "أدخل"},
    "ACCESS_SHOP_BILLING_VIEW": {
      "en": "Access shop and billing details in one view",
      "ar": "الوصول إلى تفاصيل المتجر والفوترة في عرض واحد",
    },
    "VIEW_PAYMENT_HISTORY": {
      "en": "View Payment History",
      "ar": "عرض سجل الدفعات",
    },
    "ONBOARD_BY": {"en": "Onboard By", "ar": "تم التسجيل بواسطة"},
    "NAME": {"en": "Name", "ar": "الاسم"},
    "EMAIL": {"en": "Email", "ar": "البريد الإلكتروني"},
    "GOVT_ID": {"en": "Govt. Issued ID", "ar": "الهوية الصادرة عن الحكومة"},
    "COUNTRY": {"en": "Country", "ar": "الدولة"},
    "CITY": {"en": "City", "ar": "المدينة"},
    "PIN_CODE": {"en": "Pin Code", "ar": "الرمز البريدي"},
    "MALL_NAME": {"en": "Mall Name", "ar": "اسم المركز التجاري"},
    "ADDRESS_LINE": {"en": "Apartment No./Street", "ar": "رقم الشقة / الشارع"},
    "EMIRATE": {"en": "Emirate / State", "ar": "الإمارة / الولاية"},
    "SHOP_ADMIN_DETAILS": {
      "en": "Shop Admin Details",
      "ar": "تفاصيل مدير المتجر",
    },
    "ADMIN_NAME": {"en": "Admin name", "ar": "اسم المدير"},
    "ADMIN_ALT_PHONE": {"en": "Alt,mobile number", "ar": "رقم الجوال البديل"},
    "ADMIN_PHONE": {"en": "Mobile number", "ar": "رقم الجوال"},
    "ADMIN_EMAIL": {"en": "email ID", "ar": "البريد الإلكتروني"},
    "RAFFLE_CARD_DETAILS": {
      "en": "Raffle Card Details",
      "ar": "تفاصيل بطاقة السحب",
    },
    "JACKPOT_TICKETS": {
      "en": "No.of Jackpot Tickets",
      "ar": "عدد تذاكر الجائزة الكبرى",
    },
    "BILLING_PAYMENT_DETAILS": {
      "en": "Billing and Payments Details",
      "ar": "تفاصيل الفواتير والمدفوعات",
    },
    "TOTAL_PURCHASE_VALUE": {
      "en": "Total Purchase Value",
      "ar": "إجمالي قيمة الشراء",
    },
    "TOTAL_BILLED_AMOUNT": {
      "en": "Total Billed amount",
      "ar": "إجمالي الفاتورة",
    },
    "OVER_DUE_AMOUNT": {"en": "Over due amount", "ar": "المبلغ المتأخر"},
    "DUE_PERIOD": {"en": "Due period", "ar": "فترة الاستحقاق"},
    "NO_BILLING_HISTORY": {
      "en": "No Billing History available !",
      "ar": "لا يوجد سجل فواتير متاح",
    },
    "SEARCH_HINT": {
      "en": "Search by email",
      "ar": "ابحث عن طريق البريد الإلكتروني",
    },
    "PAYMENT_HISTORY": {"en": "Payment History", "ar": "سجل المدفوعات"},
    "FILTER_SHEET_TITLE": {"en": "Filters", "ar": "فلاتر"},
    "DUE_DATE": {"en": "Due Date", "ar": "تاريخ الاستحقاق"},
    "PAID_DATE": {"en": "Paid Date", "ar": "تاريخ الدفع"},
    "BILLED_DATE": {"en": "Billed Date", "ar": "تاريخ الفاتورة"},
    "START_DATE": {"en": "Start Date", "ar": "تاريخ البدء"},
    "END_DATE": {"en": "End Date", "ar": "تاريخ الانتهاء"},
    "SELECT": {"en": "Select", "ar": "اختر"},
    "PAID_DATE_LABEL": {"en": "Paid date", "ar": "تاريخ الدفع"},
    "DUE_DATE_LABEL": {"en": "Due Date", "ar": "تاريخ الاستحقاق"},
    "BILLED_DATE_LABEL": {"en": "Billed Date", "ar": "تاريخ الفاتورة"},
    "BILL_PERIOD": {"en": "Bill Period", "ar": "فترة الفاتورة"},
    "PAYMENT_STATUS": {"en": "Payment Status", "ar": "حالة الدفع"},
    "STATUS_ACTIVE": {"en": "Active", "ar": "نشط"},
    "STATUS_PAID": {"en": "Paid", "ar": "مدفوع"},
    "STATUS_PENDING": {"en": "Pending", "ar": "معلق"},
    "ADJUSTMENT": {"en": "Adjustment", "ar": "تعديل"},
    "TOTAL_SOLD_AMOUNT": {"en": "Total Sold Amount", "ar": "إجمالي المبيعات"},
    "TOTAL_RAFFLE_TICKETS": {
      "en": "Total Raffle Tickets",
      "ar": "إجمالي تذاكر السحب",
    },
    "TRANSACTIONS": {"en": "Transactions", "ar": "المعاملات"},
    "VIEW_HISTORY": {"en": "View History", "ar": "عرض السجل"},
    "NO_HISTORY_AVAILABLE": {
      "en": "No history available",
      "ar": "لا يوجد سجل متاح",
    },
    "ADJUSTMENT_HISTORY_TITLE": {
      "en": "Adjustment history",
      "ar": "تاريخ التعديلات",
    },
    "ADJUSTMENT_HISTORY_SUBTITLE": {
      "en": "See a history of adjustments made on this bill.",
      "ar": "شاهد سجل التعديلات التي تم إجراؤها على هذه الفاتورة.",
    },
    "BILL_PERIOD_LABEL": {"en": "Bill Period -", "ar": "فترة الفاتورة -"},
    "BILL_SUMMARY_TITLE": {
      "en": "Bill Summary (LKR)",
      "ar": "ملخص الفاتورة (درهم)",
    },
    "TOTAL_ADJUSTMENT": {"en": "Total Adjustment", "ar": "إجمالي التعديلات"},
    "ROLLED_OVER_ADJUSTMENT": {
      "en": "Rolled over Adjustment",
      "ar": "التعديل المرحل",
    },
    "ADJUSTMENT_CHANGE_REQUESTS": {
      "en": "Adjustment - Change Requests",
      "ar": "التعديل - طلبات التغيير",
    },
    "DATE": {"en": "Date", "ar": "التاريخ"},
    "EXISTING_VALUE": {"en": "EXISTING VALUE", "ar": "القيمة الحالية"},
    "NEW_VALUE": {"en": "NEW VALUE", "ar": "القيمة الجديدة"},
    "NO_TRANSACTION_AVAILABLE": {
      "en": "No Transaction available !",
      "ar": "لا توجد معاملات متاحة",
    },
    "TRANSACTION_BY_DATE": {
      "en": "Transaction by Date",
      "ar": "المعاملات حسب التاريخ",
    },
    "TICKET_COUNT": {"en": "Ticket Count", "ar": "عدد التذاكر"},
    "PURCHASE_VALUE_FILTER": {"en": "Purchase Value", "ar": "قيمة الشراء"},
    "TICKET_COUNT_FILTER": {"en": "Ticket Count", "ar": "عدد التذاكر"},
    "DUE_AMOUNT": {"en": "Due Amount", "ar": "المبلغ المستحق"},
    "BY_DATE": {"en": "Transaction by Date", "ar": "المعاملة حسب التاريخ"},
    "CREATED_DATE": {"en": "Created Date", "ar": "تاريخ الإنشاء"},
    "RAFFLE_ENTRIES": {"en": "Raffle Entries", "ar": "تذاكر السحب"},
    "ERROR_MESSAGE": {
      "en": "Something went wrong, please try again later",
      "ar": "حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا",
    },
    "CUSTOMER_EMAIL_ID": {
      "en": "Customer Email ID",
      "ar": "البريد الإلكتروني للعميل",
    },
    "MOBILE_NUMBER": {"en": "Mobile Number", "ar": "رقم الجوال"},
    "CASHIER": {"en": "Cashier", "ar": "أمين الصندوق"},
    "HISTORY_OF_TRANSACTION_AND_CHANGES": {
      "en": "History of Transaction and Changes",
      "ar": "سجل المعاملات والتغييرات",
    },
    "STATUS_REJECTED": {"en": "Rejected", "ar": "مرفوض"},
    "STATUS_CANCELLED": {"en": "Cancelled", "ar": "ألغيت"},
    "STATUS_APPROVED": {"en": "Approved", "ar": "موافق عليه"},
    "CHANGE_REQ": {"en": "Change Req", "ar": "تغيير الطلب"},
    "ACTION_REQUIRED": {"en": "Action Required!", "ar": "!الإجراء مطلوب"},
    "FILTER_CR_COUNT": {"en": "CR Count", "ar": "عدد طلبات التغيير"},
    "MIN_COUNT": {"en": "Min count", "ar": "الحد الأدنى"},
    "MAX_COUNT": {"en": "Max count", "ar": "الحد الأقصى"},
    "FILTER_TITLE": {"en": "Filters", "ar": "تصفية"},
    "FILTER_APPLIED_CR_COUNT": {
      "en": "Change Request count",
      "ar": "عدد طلبات التغيير",
    },
    "SHOP_ADMIN_LABEL": {"en": "Shop Admin", "ar": "مسؤول المتجر"},
    "TOTAL_CR_LABEL": {"en": "Total CR", "ar": "إجمالي طلبات التغيير"},
    "PENDING_CR_LABEL": {"en": "Pending CR", "ar": "طلبات التغيير المعلقة"},
    "ACCOUNT_MANAGER_LABEL": {"en": "Account Manager", "ar": "مدير الحساب"},
    "CR_HISTORY_BTN": {"en": "CR History", "ar": "سجل التغييرات"},
    "CHANGE_REQUEST_HISTORY_TITLE": {
      "en": "History of Change Request",
      "ar": "سجل طلبات التغيير",
    },
    "FILTERS_TITLE": {"en": "Filters", "ar": "عوامل التصفية"},
    "SELECT_HINT": {"en": "Select", "ar": "حدد"},
    "EMPTY_LIST": {"en": "Empty List", "ar": "القائمة فارغة"},
    "PULL_REFRESH": {
      "en": "Minimum two characters for searching",
      "ar": "حرفين على الأقل للبحث",
    },
    "MINIMUM_TWO": {
      "en": "Minimum two characters for searching",
      "ar": "حرفين على الأقل للبحث",
    },
    "NO_HISTORY": {"en": "No History availbale !", "ar": "لا يوجد تاريخ متاح"},
    "ONBOARDED_BY": {"en": "Onboarded By", "ar": "على متن الطائرة بواسطة"},
    "SEARCH_BY_BILLED": {
      "en": "Search by billed amount",
      "ar": "البحث حسب المبلغ المفوتر",
    },
    "PERSONAL_DETAILS": {"en": "Personal Details", "ar": "تفاصيل شخصية"},
    "PROFILE_PICTURE": {"en": "Profile Picture", "ar": "صورة الملف الشخصي"},
    "CHANGE_PASSWORD": {"en": "Change Password", "ar": "تغيير كلمة المرور"},
    "TEAM_MANAGEMENT": {"en": "Team Management", "ar": "إدارة الفريق"},
    "HELP_SUPPORT": {"en": "Help & Support", "ar": "المساعدة والدعم"},
    "LOG_OUT": {"en": "Log Out", "ar": "تسجيل الخروج"},
    "MY_PROFILE": {"en": "My Profile", "ar": "ملفي الشخصي"},
    "MOBILE_NO": {"en": "Mobile No", "ar": "رقم الجوال"},
    "NUMBER_VALIDATION": {
      "en": "Number should be between  and  digits",
      "ar": "يجب أن يكون الرقم بين  و  رقمًا",
    },
    "NAME_TOO_SHORT": {
      "en": "Name must be at least 3 characters",
      "ar": "يجب أن يكون الاسم 3 أحرف على الأقل",
    },
    "EDIT_PERSONAL_DETAILS": {
      "en": "Edit Personal Details",
      "ar": "تحرير التفاصيل الشخصية",
    },
    "SAVE": {"en": "Save", "ar": "حفظ"},
    "SELECT_IMAGE": {"en": "Please select an image.", "ar": "يرجى تحديد صورة."},
    "PASSWORD_MISMATCH": {
      "en": "New Password and Confirm Password do not match",
      "ar": "كلمة المرور الجديدة وتأكيد كلمة المرور غير متطابقين",
    },
    "PASSWORD_CHANGE_SUCCESS": {
      "en": "Password changed successfully",
      "ar": "تم تغيير كلمة المرور بنجاح",
    },
    "PASSWORD_CHANGE_FAILED": {
      "en": "Failed to change password",
      "ar": "فشل تغيير كلمة المرور",
    },
    "NEW_PASSWORD": {"en": "New Password", "ar": "كلمة المرور الجديدة"},
    "CONFIRM_NEW_PASSWORD": {
      "en": "Confirm New Password",
      "ar": "تأكيد كلمة المرور الجديدة",
    },
    "CURRENT_PASSWORD": {"en": "Current Password", "ar": "كلمة المرور الحالية"},
    "HELP_MESSAGE": {
      "en":
      "Please reach out to the below contacts for anything you may require.",
      "ar": "يرجى التواصل مع جهات الاتصال أدناه لأي شيء قد تحتاجه.",
    },
    "ACCOUNT_MANAGER_DETAILS": {
      "en": "Account Manager Details",
      "ar": "تفاصيل مدير الحساب",
    },
    "ESCALATION_CONTACT_DETAILS": {
      "en": "Escalation Contact Details",
      "ar": "تفاصيل جهة الاتصال للتصعيد",
    },
    "COPIED_CLIPBOARD": {
      "en": "Copied to clipboard",
      "ar": "تم النسخ إلى الحافظة",
    },
    "NUMBER_SHOULD_BE_BETWEEN": {
      "en": "Number should be between",
      "ar": "يجب أن يكون الرقم بين",
    },
    "AND": {"en": "and", "ar": "و"},
    "DIGITS": {"en": "digits", "ar": "أرقام"},
    "TEAM": {"en": "Team", "ar": "الفريق"},
    "CASHIER_NAME_EMAIL_MOBILE": {
      "en": "Cashier Name, Email, Mobile No",
      "ar": "اسم الصراف، البريد الإلكتروني، رقم الجوال",
    },
    "ONBOARD_SALES_REP": {
      "en": "Onboard Sales Rep",
      "ar": "إلحاق مندوب المبيعات",
    },
    "ONBOARD": {"en": "Onboard", "ar": "إلحاق"},
    "TOTAL_PURCHASE": {"en": "Total Purchase", "ar": "إجمالي المشتريات"},
    "ONBOARD_DATE": {"en": "Onboard Date", "ar": "تاريخ الالتحاق"},
    "DELETE": {"en": "Delete", "ar": "حذف"},
    "TEAM_EDIT": {"en": "Edit Team", "ar": "تحرير الفريق"},
    "CASHIER_ONBOARDING": {"en": "Cashier Onboarding", "ar": "تسجيل الصراف"},
    "SALES_ADMIN_ONBOARD": {
      "en": "Sales Admin Onboard",
      "ar": "إلحاق مدير المبيعات",
    },
    "SALES_REP_DETAILS": {
      "en": "Sales Rep Details",
      "ar": "تفاصيل مندوب المبيعات",
    },
    "SALES_ADMIN_NAME": {"en": "Sales Admin Name", "ar": "اسم مدير المبيعات"},
    "SALES_REP": {"en": "Sales Rep", "ar": "مندوب المبيعات"},
    "SALES_REP_SHOPS": {"en": "Sales Rep Shops", "ar": "متاجر مندوب المبيعات"},
    "EMPLOYEE_ID": {"en": "Employee Id", "ar": "معرف الموظف"},
    "CASHIER_DETAILS": {"en": "Cashier Details", "ar": "تفاصيل الصراف"},
    "SEND_SECURITY_CODE": {
      "en": "Send Security Code",
      "ar": "إرسال رمز الأمان",
    },
    "SECURITY_CODE": {"en": "Security Code", "ar": "رمز الأمان"},
    "VERIFY": {"en": "Verify", "ar": "تحقق"},
    "ENTER_OTP_WITHIN": {
      "en": "Please Enter OTP within",
      "ar": "يرجى إدخال رمز التحقق خلال",
    },
    "SECONDS_DIDNT_RECEIVE": {
      "en": "seconds. Didn't receive?",
      "ar": "ثواني. لم تستلم؟",
    },
    "RESEND": {"en": "Resend", "ar": "إعادة الإرسال"},
    "NO_DATA": {"en": "No Data", "ar": "لا توجد بيانات"},
    "MIN_PURCHASE": {"en": "Min Purchase", "ar": "الحد الأدنى للشراء"},
    "MAX_PURCHASE": {"en": "Max Purchase", "ar": "الحد الأقصى للشراء"},
    "MIN_PURCHASEE": {"en": "Min Purchase", "ar": "الحد الأدنى للشراء"},
    "MAX_PURCHASEE": {"en": "Max Purchase", "ar": "الحد الأقصى للشراء"},
    "MIN_TICKETS": {"en": "Min Tickets", "ar": "الحد الأدنى للتذاكر"},
    "MAX_TICKETS": {"en": "Max Tickets", "ar": "الحد الأقصى للتذاكر"},
    "CLEAR_ALL": {"en": "Clear All", "ar": "مسح الكل"},
    "APPLY": {"en": "Apply", "ar": "تطبيق"},
    "CONFIRM_DELETE_ACCOUNT": {"en": "Are you sure?", "ar": "هل أنت متأكد؟"},
    "DELETE_ACCOUNT_PROMPT": {
      "en": "Do you really want to delete this account?",
      "ar": "هل تريد حقًا حذف هذا الحساب؟",
    },
    "YES": {"en": "Yes", "ar": "نعم"},
    "INVALID_COUNTRY_CODE": {
      "en": "Invalid country code",
      "ar": "رمز الدولة غير صالح",
    },
    "EDIT_TEAM": {"en": "Edit Team", "ar": "تحرير الفريق"},
    "INVALID_MOBILE_NUMBER": {
      "en": "Invalid Mobile Number",
      "ar": "رقم الجوال غير صالح",
    },
    "INVALID_EMAIL": {
      "en": "Enter a valid email",
      "ar": "أدخل بريدًا إلكترونيًا صالحًا",
      "jp": "有効なメールアドレスを入力してください"
    },
    "MOBILE_NUMBER_REQUIRED": {
      "en": "Mobile number is required",
      "ar": "رقم الجوال مطلوب",
    },
    "NO": {"en": "No", "ar": "لا"},
    "DELETE_SUCCESS": {"en": "Deleted successfully", "ar": "تم الحذف بنجاح"},
    "DELETE_FAILED": {"en": "Failed to Delete", "ar": "فشل الحذف"},
    "ERROR_OCCURRED": {"en": "An error occurred", "ar": "حدث خطأ"},
    "UPDATE_MOBILE_FAILED": {
      "en": "Failed to update mobile number",
      "ar": "فشل في تحديث رقم الجوال",
    },
    "UPDATE_MOBILE_SUCCESS": {
      "en": "Mobile number updated successfully",
      "ar": "تم تحديث رقم الجوال بنجاح",
    },
    "GENERAL_ERROR": {"en": "Error", "ar": "خطأ"},
    "PERSONAL_PROFILE": {
      "en": "Personal Profile",
      "ar": "الملف الشخصي",
      "ta": "தனிப்பட்ட சுயவிவரம்",
    },
    "BUSINESS_PROFILE": {
      "en": "Business Profile",
      "ar": "الملف التجاري",
      "ta": "வணிக சுயவிவரம்",
    },
    "ROLE": {"en": "Role", "ar": "الدور", "ta": "பங்கு"},
    "ADDRESS": {"en": "Address", "ar": "العنوان", "ta": "முகவரி"},
    "PROFILE": {"en": "Profile", "ar": "الملف الشخصي", "ta": "சுயவிவரம்"},
    "SETTINGS": {"en": "Settings", "ar": "الإعدادات", "ta": "அமைப்புகள்"},
    "SETTING": {"en": "Setting", "ar": "إعداد", "ta": "அமைப்பு"},
    "LANGUAGE_LIST": {"en": "Language", "ar": "لغة"},
    "EDIT": {"en": "Edit", "ar": "يحرر"},
    "UPLOAD": {"en": "Upload", "ar": "رفع", "ta": "பதிவேற்றம்"},
    "CASHIER_NAME": {"en": "Cashier Name", "ar": "اسم أمين الصندوق"},
    "LOGOUT_PROMPT": {
      "en": "Are you sure you want to log out?",
      "ar": "هل أنت متأكد أنك تريد تسجيل الخروج؟",
    },
    "EMAIL_ID": {"en": "Email ID", "ar": "البريد الإلكتروني"},
    "MALL_NAME(optional)": {
      "en": "Mall Name (optional)",
      "ar": "اسم المركز التجاري (اختياري)",
    },
    "GOVT_ISSUE_ID": {"en": "Govt. Issue ID", "ar": "الهوية الحكومية"},
    "APARTMENT_STREET": {
      "en": "Apartment No./Street",
      "ar": "رقم الشقة/الشارع",
    },
    "PIN_CODE_LENGTH": {
      "en": "PIN code must be 5 digits",
      "ar": "يجب أن يتكون الرمز البريدي من 5 أرقام",
    },
    "EMIRATE_STATE": {"en": "Emirate/State", "ar": "الإمارة/الولاية"},
    "ALTERNATIVE_MOBILE_NUMBER": {
      "en": "Alternative Mobile Number (optional)",
      "ar": "رقم الجوال البديل (اختياري)",
    },
    "ASSIGNED_TO": {"en": "Assigned To", "ar": "مخصص لـ"},
    "SALES_ADMIN": {"en": "Sales Admin", "ar": "مسؤول المبيعات"},
    "NO_OF_JACKPOT_TICKETS": {
      "en": "No. of Jackpot Tickets",
      "ar": "عدد تذاكر الجائزة الكبرى",
    },
    "BILLING_AND_PAYMENT_DETAILS": {
      "en": "Billing And Payment Details",
      "ar": "تفاصيل الفواتير والدفع",
    },
    "BILLING_CYCLE": {"en": "Billing Cycle", "ar": "دورة الفوترة"},
    "BILL_VALUE_PER_TICKET": {
      "en": "Bill Value (Per Ticket)",
      "ar": "قيمة الفاتورة (لكل تذكرة)",
    },
    "PROOF_DETAILS": {
      "en": "Proof Details (JPEG, PNG, PDF, DOC)",
      "ar": "تفاصيل الإثبات (JPEG, PNG, PDF, DOC)",
    },
    "ADDRESS_DETAILS": {"en": "Address Details", "ar": "تفاصيل العنوان"},
    "ID_PROOFS": {"en": "ID Proofs", "ar": "إثبات الهوية"},
    "VIEW": {"en": "View", "ar": "عرض"},
    "CANCEL": {"en": "Cancel", "ar": "إلغاء"},
    "SHOP_ONBOARDING": {"en": "Shop - Onboarding", "ar": "تسجيل المتجر"},
    "SHOP_PHOTO": {"en": "Shop Photo", "ar": "صورة المتجر"},
    "SHOP_LOGO": {"en": "Shop Logo", "ar": "شعار المتجر"},
    "BUSINESS_DESCRIPTION": {
      "en": "Business Description",
      "ar": "وصف النشاط التجاري",
    },
    "NEXT": {"en": "Next", "ar": "التالي"},
    "SEND_CODE": {"en": "Send Code", "ar": "إرسال الرمز"},
    "SENT": {"en": "Sent", "ar": "تم الإرسال"},
    "VERIFICATION": {"en": "Verification", "ar": "التحقق"},
    "VERIFIED": {"en": "Verified", "ar": "تم التحقق"},
    "SALES_TEAM": {"en": "Sales Team", "ar": "فريق المبيعات"},
    "UPLOAD_GOVT_ISSUED_ID": {
      "en": "Upload Govt Issued ID proofs. Max Size 5MB",
      "ar": "تحميل إثبات الهوية الحكومية. الحد الأقصى للحجم 5 ميغابايت",
    },
    "VIEW_SHOP_DETAILS": {"en": "View Shop Details", "ar": "عرض تفاصيل المتجر"},
    "ONBOARD_SHOP": {"en": "Onboard Shop", "ar": "متجر الإلحاق"},
    "SHOP_TOP": {
      "en":
      "Manage shops efficiently by onboarding new shops, updating shop details, and reviewing onboarding requests for approval or rejection. ",
      "ar":
      "قم بإدارة المتاجر بكفاءة من خلال إلحاق المتاجر الجديدة، وتحديث تفاصيل المتجر، ومراجعة طلبات الإلحاق للموافقة أو الرفض ",
    },
    "SEARCH": {"en": "Search", "ar": "بحث"},
    "SEARCH_BY_NAME": {
      "en": "Search by Admin Name",
      "ar": "البحث حسب اسم المسؤول",
    },
    "MIN_3_CHARS": {
      "en": "Search min 3 characters",
      "ar": "البحث يتطلب على الأقل حرفين",
    },
    "UPLOAD_FROM_GALLERY": {
      "en": "Upload From Gallery",
      "ar": "تحميل من المعرض",
      "ta": "கேலரியிலிருந்து பதிவேற்றவும்",
    },
    "SHOP_ONBOARDING_TITLE": {"en": "Shop-Onboarding", "ar": "إعداد المتجر"},
    "PREVIOUS": {"en": "Previous", "ar": "السابق"},
    "UPDATE": {"en": "Update", "ar": "تحديث"},
    "BUSINESS_DESCRIPTION_REQUIRED": {
      "en": "Business Description is required",
      "ar": "وصف النشاط التجاري مطلوب",
    },
    "BUSINESS_DESCRIPTION_MIN_LENGTH": {
      "en": "Business Description must be at least 15 characters",
      "ar": "يجب أن يكون وصف النشاط التجاري 15 أحرف على الأقل",
    },
    "SHOP_NAME_REQUIRED": {
      "en": "Shop Name is required",
      "ar": "اسم المتجر مطلوب",
    },
    "SHOP_NAME_MIN_LENGTH": {
      "en": "Shop Name must be at least 3 characters",
      "ar": "يجب أن يكون اسم المتجر 3 أحرف على الأقل",
    },
    "MALL_NAME_REQUIRED": {
      "en": "Mall Name is required",
      "ar": "اسم المركز التجاري مطلوب",
    },
    "MALL_NAME_MIN_LENGTH": {
      "en": "Mall Name must be at least 3 characters",
      "ar": "يجب أن يكون اسم المركز التجاري 3 أحرف على الأقل",
    },
    "GOVT_ID_LABEL": {
      "en": "Govt. Issued ID",
      "ar": "الهوية الصادرة من الحكومة",
    },
    "GOVT_ID_REQUIRED": {
      "en": "Govt. Issued ID is required",
      "ar": "الهوية الحكومية مطلوبة",
    },
    "GOVT_ID_MIN_LENGTH": {
      "en": "Govt. Issued ID must be at least 5 characters",
      "ar": "يجب أن تكون الهوية الحكومية 5 أحرف على الأقل",
    },
    "ADDRESS_LINE1_LABEL": {
      "en": "Apartment No./Street Name",
      "ar": "رقم الشقة / اسم الشارع",
    },
    "ADDRESS_LINE1_REQUIRED": {
      "en": "Apartment No./Street Name is required",
      "ar": "رقم الشقة / اسم الشارع مطلوب",
    },
    "ADDRESS_LINE1_MIN_LENGTH": {
      "en": "Apartment No./Street Name must be at least 3 characters",
      "ar": "يجب أن يكون رقم الشقة / اسم الشارع 3 أحرف على الأقل",
    },
    "AREA_REQUIRED": {"en": "Area is required", "ar": "المنطقة مطلوبة"},
    "AREA_MIN_LENGTH": {
      "en": "Area must be at least 3 characters",
      "ar": "يجب أن تكون المنطقة 3 أحرف على الأقل",
    },
    "PINCODE_REQUIRED": {
      "en": "Pin Code is required",
      "ar": "الرمز البريدي مطلوب",
    },
    "PINCODE_EXACT_LENGTH": {
      "en": "Pin Code must be exactly 6 digits",
      "ar": "يجب أن يكون الرمز البريدي 6 أرقام بالضبط",
    },
    "ENTER_YOUR_NUMBER": {"en": "Enter your number", "ar": "أدخل رقمك"},
    "ALTERNATIVE_NUMBER": {"en": "Alternative Number", "ar": "رقم بديل"},
    "ENTER_ALTERNATIVE_NUMBER": {
      "en": "Enter your Alternative number",
      "ar": "أدخل رقمك البديل",
    },
    "EMAIL_REQUIRED": {
      "en": "Please enter your email",
      "ar": "يرجى إدخال بريدك الإلكتروني",
      "jp": "メールアドレスを入力してください"
    },
    "EMAIL_INVALID": {
      "en": "Please enter a valid email address",
      "ar": "يرجى إدخال عنوان بريد إلكتروني صالح",
    },
    "PURCHASE_VALUE_REQUIRED": {
      "en": "Purchase Value is required",
      "ar": "قيمة الشراء مطلوبة",
    },
    "JACKPOT_TICKETS_REQUIRED": {
      "en": "No of Jackpot Tickets is required",
      "ar": "عدد تذاكر الجاكبوت مطلوب",
    },
    "BILL_VALUE_REQUIRED": {
      "en": "Bill Value is required",
      "ar": "قيمة الفاتورة مطلوبة",
    },
    "DUE_PERIOD_LABEL": {
      "en": "Due Period (Max 15 Days)",
      "ar": "فترة الاستحقاق (بحد أقصى 15 يومًا)",
    },
    "DUE_PERIOD_REQUIRED": {
      "en": "Due Period is required",
      "ar": "فترة الاستحقاق مطلوبة",
    },
    "PROOF_DETAILS_LABEL": {
      "en": "Proof Details (JPG, PNG, PDF, DOC)",
      "ar": "تفاصيل الإثبات (JPG، PNG، PDF، DOC)",
    },
    "ID_PROOF": {"en": "ID Proof", "ar": "إثبات الهوية"},
    "ENTER_YOUR_NAME": {
      "en": "Please enter your name",
      "ar": "يرجى إدخال اسمك",
    },
    "NAME_MIN_LENGTH": {
      "en": "Name must be at least 3 characters long",
      "ar": "يجب أن يكون الاسم 3 أحرف على الأقل",
    },
    "PIN_CODE_REQUIRED": {
      "en": "Pin Code is required",
      "ar": "الرمز البريدي مطلوب",
    },
    "REVENUE_LABEL": {"en": "Revenue", "ar": "الإيرادات"},
    "TOTAL_REVENUE_MIN": {
      "en": "Total Revenue Min",
      "ar": "إجمالي الإيرادات (الحد الأدنى)",
    },
    "TOTAL_REVENUE_MAX": {
      "en": "Total Revenue Max",
      "ar": "إجمالي الإيرادات (الحد الأقصى)",
    },
    "REJECT": {"en": "Reject", "ar": "رفض"},
    "ENTER_MOBILE_NUMBER": {
      "en": "Enter your Mobile number",
      "ar": "أدخل رقم هاتفك المحمول",
    },
    "PROOF": {"en": "Proof", "ar": "إثبات"},
    "SELECT_BILLING_CYCLE": {
      "en": "Select Billing Cycle",
      "ar": "حدد دورة الفوترة",
    },
    "LOGIN_PASSWORD_ERROR": {
      "en": "Password cannot be empty",
      "ar": "لا يمكن أن تكون كلمة المرور فارغة",
      "jp": "パスワードを空にすることはできません",
    },
    "LOGIN_PASSWORD_ERROR_1": {
      "en": "Password must be at least 8 characters,\ninclude 1 uppercase letter, 1 number & 1 special character.",
      "ar": "يجب أن تكون كلمة المرور 8 أحرف على الأقل، وتشمل حرفًا كبيرًا واحدًا، ورقمًا واحدًا، وحرفًا خاصًا واحدًا.",
      "jp": "パスワードは8文字以上で、1つの大文字、1つの数字、1つの特殊文字を含める必要があります。"
    },
    "NO_ALERTS_YET": {"en": '" No Alerts yet "', "ar": 'لا توجد تنبيهات بعد'},
    "ALERTS": {"en": 'Alerts', "ar": 'التنبيهات'},
    "DAY": {"en": "Day", "ar": "يوم"},
    "DRAWS": {"en": "Draws", "ar": "السحوبات"},
    "ACCOUNT_MANAGEMENT": {"en": "Account Management", "ar": "إدارة الحساب"},

    "MY_RAFFLE_RECORDS": {
      "en": "My Raffle Records",
      "ar": "سجلات السحب الخاصة بي",
    },

    "UPCOMING_TICKETS_DESCRIPTION": {
      "en":
      "Your upcoming Raffle Tickets in one convenient place. Explore & get ready to win!",
      "ar":
      "تذاكر السحب القادمة الخاصة بك في مكان واحد مناسب. استكشف واستعد للفوز!",
    },

    "WINNING_TICKETS_DESCRIPTION": {
      "en": "Congratulations on your win! Your winning tickets at a glance.",
      "ar": "تهانينا على فوزك! تذاكر الفوز الخاصة بك في لمحة.",
    },

    "PENDING_CLAIMS_DESCRIPTION": {
      "en":
      "Unclaimed wins? Find them here. Claim your prizes before it's too late!",
      "ar": "لم تُطالب بجوائزك؟ اعثر عليها هنا. طالب بجوائزك قبل فوات الأوان!",
    },
    "MY_RAFFLE": {"en": "My Raffle", "ar": "سحبي"},
    "WINNING": {"en": "Winning", "ar": "الفوز"},
    "THIS_WEEK": {"en": "This Week", "ar": "هذا الأسبوع"},
    "MY": {"en": "My", "ar": "الخاصة بي"},
    "PENDING_CLAIMS": {"en": "Pending Claims", "ar": "المطالبات المعلقة"},
    "CLAIM": {"en": "Claim", "ar": "يطالب"},
    "UPCOMING": {"en": "Upcoming", "ar": "قادمة"},
    "CREDIT": {"en": "Credit", "ar": "رصيد"},
    "YOU_VE_WON": {"en": "You've won", "ar": "لقد فزت"},
    "DRAW_ID": {"en": "DrawID", "ar": "رقم السحب"},
    "DRAW_DATE": {"en": "DrawDate", "ar": "تاريخ السحب"},
    "CLAIM_PENDING": {"en": "Pending Claims", "ar": "المطالبات المعلقة"},
    "COMPLETED_CLAIMS": {"en": "Completed Claims", "ar": "المطالبات المكتملة"},
    "ORDER_MANAGEMENT": {"en": "Order Management", "ar": "إدارة الطلبات"},
    "MY_REDEMPTIONS": {"en": "My Redemptions", "ar": "استرداداتي"},
    "MY_CLAIMS": {"en": "My Claims", "ar": "مطالباتي"},
    "NEW_REDEMPTIONS": {"en": "Upcoming Entries", "ar": "الإدخالات القادمة"},
    "PAST_REDEMPTIONS": {"en": "Past Rewards", "ar": "المكافآت الماضية"},
    "EXPIRED": {"en": "Expired", "ar": "منتهية"},
    "MY_CREDITS": {"en": "My Credits", "ar": "أرصدتي"},
    "AVAILABLE_REDEMPTION_CREDITS": {
      "en": "Available Redemption Credits",
      "ar": "أرصدة الاسترداد المتاحة",
    },
    "SHOPS": {"en": "Shops", "ar": "المتاجر"},
    "CREDITS": {"en": "Credits", "ar": "أرصدة"},
    "EXPIRE_IN": {"en": "Expire in", "ar": "تنتهي خلال"},
    "DAYS": {"en": "days", "ar": "أيام"},
    "WELCOME_MSG": {
      "en": "Welcome to Shop & Win Lanka",
      "ar": "مرحباً بكم في Shop & Win Lanka",
    },
    "OVERVIEW": {"en": "Overview", "ar": "نظرة عامة"},
    "IMPACT": {"en": "Impact", "ar": "التأثير"},
    "WHAT_YOU_GET": {"en": "What You get", "ar": "ما ستحصل عليه"},
    "REDEMPTION_INFO": {
      "en":
      "Shop at our partner outlets and earn reward credits based on your purchase value. These credits can be redeemed for exclusive rewards through our app or website.\nReward distributions are conducted regularly and managed through a transparent, system-driven process. Customers can view their reward entries and claim their rewards with ease.",
      "ar":
      "تسوق في منافذ شركائنا واحصل على نقاط مكافآت بناءً على قيمة مشترياتك. يمكنك استبدال هذه النقاط بمكافآت حصرية عبر تطبيقنا أو موقعنا الإلكتروني. يتم توزيع المكافآت بانتظام، وتُدار من خلال عملية شفافة ومُدارة بنظام مُحكم. يمكن للعملاء الاطلاع على بيانات مكافآتهم واستلامها بسهولة.",
    },
    "CUSTOMER_HAPPY_MSG": {
      "en":
      "Our platform helps customers enjoy exclusive rewards while offering shop owners a seamless, plug-and-play rewards solution that boosts engagement and loyalty.",
      "ar":
      "تساعد منصتنا العملاء على الاستمتاع بمكافآت حصرية مع تقديم حل مكافآت سلس وسهل الاستخدام لأصحاب المتاجر، مما يعزز المشاركة والولاء.",
    },
    "DREAM_COME_TRUE": {
      "en":
      "Discover a seamless rewards experience for both shoppers and retail partners.",
      "ar":
      "اكتشف تجربة مكافآت سلسة لكل من المتسوقين وشركاء البيع بالتجزئة. يستمتع العملاء بسهولة الوصول إلى العروض والمكافآت الحصرية من خلال عملية بسيطة تعتمد على النظام - بدون اختيارات يدوية أو خطوات معقدة. بالنسبة لشركاء البيع بالتجزئة، يوفر Shop & Win Lanka منصة مرنة وسهلة التكامل تعمل على تعزيز تفاعل العملاء وتعزيز رؤية العلامة التجارية. انضم إلينا في تقديم تجربة تسوق مجزية للجميع المعنيين!",
    },
    "DREAM_COME_TRUE_1": {
      "en":
      "\nCustomers enjoy easy access to exclusive offers and rewards through a simple, system-driven process — no manual selections or complicated steps.",
      "ar":
      "اكتشف تجربة مكافآت سلسة لكل من المتسوقين وشركاء البيع بالتجزئة. يستمتع العملاء بسهولة الوصول إلى العروض والمكافآت الحصرية من خلال عملية بسيطة تعتمد على النظام - بدون اختيارات يدوية أو خطوات معقدة. بالنسبة لشركاء البيع بالتجزئة، يوفر Shop & Win Lanka منصة مرنة وسهلة التكامل تعمل على تعزيز تفاعل العملاء وتعزيز رؤية العلامة التجارية. انضم إلينا في تقديم تجربة تسوق مجزية للجميع المعنيين!",
    },
    "DREAM_COME_TRUE_2": {
      "en":
      "\nFor retail partners, Shop & Win Lanka provides a flexible, easy-to-integrate platform that enhances customer engagement and boosts brand visibility.\nJoin us in delivering a rewarding shopping experience for everyone involved!",
      "ar":
      "اكتشف تجربة مكافآت سلسة لكل من المتسوقين وشركاء البيع بالتجزئة. يستمتع العملاء بسهولة الوصول إلى العروض والمكافآت الحصرية من خلال عملية بسيطة تعتمد على النظام - بدون اختيارات يدوية أو خطوات معقدة. بالنسبة لشركاء البيع بالتجزئة، يوفر Shop & Win Lanka منصة مرنة وسهلة التكامل تعمل على تعزيز تفاعل العملاء وتعزيز رؤية العلامة التجارية. انضم إلينا في تقديم تجربة تسوق مجزية للجميع المعنيين!",
    },
    "TESTIMONIALS": {"en": "TESTIMONIALS", "ar": "آراء العملاء"},
    "CUSTOMER_EXPERIENCE": {
      "en": "Let’s hear Customer Experience",
      "ar": "دعونا نستمع إلى تجربة العملاء",
    },
    "JACKPOT": {"en": "JACKPOT", "ar": "الجائزة الكبرى"},
    "SHOP_AND_WIN": {
      "en": "Shop and earn reward credits effortlessly!",
      "ar": "تسوق واحصل على نقاط المكافأة بكل سهولة!",
    },
    "LEARN_MORE": {"en": "Learn more", "ar": "اعرف المزيد"},
    "PLAY_RAFFLE": {"en": "Play Raffle", "ar": "العب السحب"},
    "RAFFLE_INTRO": {
      "en":
      "Shop & Win Lanka conducts prize draws and invests the funds generated for the betterment of the community. The company strongly believes in the value of rewards and endeavours to make them accessible to all. Your data is safe with us. You can delete your account or unsubscribe at any moment by accessing your account settings.",
      "ar":
      "تُجري تسوق واربح لانكا سحوبات على جوائز وتستثمر العائدات المُحصّلة منها في خدمة المجتمع . تؤمن الشركة إيمانًا راسخًا بقيمة المكافآت وتسعى جاهدةً لجعلها في متناول الجميع. بياناتك في أمان تام لدينا. يمكنك حذف حسابك أو إلغاء اشتراكك في أي وقت من خلال إعدادات حسابك.",
    },
    "USEFUL_LINKS": {"en": "Useful Links", "ar": "روابط مفيدة"},
    "ABOUT_US": {"en": "About Us", "ar": "معلومات عنا"},
    "HOW_TO_PLAY": {"en": "How To Play", "ar": "كيفية اللعب"},
    "MY_RAFFLES": {"en": "My Raffle(s)", "ar": "سحباتي"},
    "NEWS": {"en": "News", "ar": "الأخبار"},
    "HELP": {"en": "Helps", "ar": "مساعدة"},
    "CONTACT": {"en": "Contact", "ar": "اتصل بنا"},
    "FAQS": {"en": "FAQs", "ar": "الأسئلة الشائعة"},
    "TERMS_CONDITION": {"en": "Terms & Condition", "ar": "الشروط والأحكام"},
    "PRIVACY_POLICY": {"en": "Privacy Policy", "ar": "سياسة الخصوصية"},
    "DOWNLOAD_APP": {"en": "Download Mobile App", "ar": "تحميل تطبيق الهاتف"},
    "COPYRIGHT": {
      "en": "Raffle © All Rights Reserved",
      "ar": "السحب © جميع الحقوق محفوظة",
    },
    "UPDATE_PASSWORD_INFO": {
      "en":
      "Update your account security by changing your password here. Enter your current password and new password below to change your account password.",
      "ar":
      "قم بتحديث أمان حسابك من خلال تغيير كلمة المرور هنا. أدخل كلمة المرور الحالية والجديدة أدناه لتغيير كلمة مرور حسابك.",
    },
    "DELETE_ACCOUNT": {"en": "Delete Account", "ar": "حذف الحساب"},
    "DELETE_MY_ACCOUNT_AND_DATA": {
      "en": "Delete My Account and Data",
      "ar": "حذف حسابي وبياناتي",
    },
    "DELETE_ACCOUNT_INFO": {
      "en":
      "Delete Account: Permanently remove your account and associated data from the application.",
      "ar": "حذف الحساب: إزالة حسابك وبياناتك المرتبطة من التطبيق بشكل دائم.",
    },
    "VERIFY_EMAIL_FOR_DELETE": {
      "en": "You need to verify your mail ID to delete your account.",
      "ar": "تحتاج إلى التحقق من بريدك الإلكتروني لحذف حسابك.",
    },
    "LAST_NAME": {
      "en": "Last Name",
      "ar": "الاسم الأخير",
      "jp": "姓"
    },
    "LAST_NAME_REQUIRED": {
      "en": "Last Name is Required",
      "ar": "الاسم الأخير مطلوب",
      "jp": "姓は必須です"
    },
    "MIN_3_CHAR": {
      "en": "Min 3 Char",
      "ar": "الحد الأدنى 3 أحرف",
      "jp": "最小3文字"
    },
    "FULL_NAME": {"en": "Full Name", "ar": "الاسم الكامل"},
    "FULL_NAME_REQUIRED": {
      "en": "Full Name is Required",
      "ar": "الاسم الكامل مطلوب",
    },
    "CONFIRM_PASSWORD": {
      "en": "Please confirm your password",
      "ar": "يرجى تأكيد كلمة المرور",
      "jp": "パスワードを確認してください"
    },
    "EMIRATES_NUMBER": {"en": "Emirates Number", "ar": "رقم الهوية الإماراتية"},
    "PASSPORT_NUMBER": {"en": "Passport Number", "ar": "رقم جواز السفر"},
    "EMIRATES_OR_PASSPORT": {
      "en": "Emirates or Passport number",
      "ar": "رقم الهوية الإماراتية أو جواز السفر",
    },
    "INVALID_EMIRATES_ID": {
      "en": "Invalid Emirates ID format",
      "ar": "تنسيق رقم الهوية الإماراتية غير صالح",
    },
    "INVALID_PASSPORT_NUMBER": {
      "en": "Invalid Passport Number format",
      "ar": "تنسيق رقم جواز السفر غير صالح",
    },
    "REGISTER": {
      "en": "REGISTER",
      "ar": "تسجيل",
      "jp": "登録"
    },
    "MEET_THE_WINNERS": {"en": "Meet the Winners", "ar": "قابل الفائزين"},
    "YOUR_NEXT_WINNING_MOMENT": {
      "en": "Your Next Winning Moment Could Be Here!",
      "ar": "قد تكون لحظة فوزك التالية هنا!",
    },
    "CONGRATULATIONS_WINNERS": {
      "en":
      "Congratulations to our winners! These fortunate individuals have won amazing prizes, and we’re proud to showcase their achievements.",
      "ar":
      "تهانينا للفائزين! هؤلاء الأشخاص المحظوظون فازوا بجوائز رائعة، ونحن فخورون بعرض إنجازاتهم.",
    },
    "SEE_WINNERS_GET_INSPIRED": {
      "en":
      "See who’s taken home the big rewards and get inspired to participate in the next draw.",
      "ar": "شاهد من فاز بالجوائز الكبرى واستلهم للمشاركة في السحب القادم.",
    },
    "NO_MORE_MESSAGES": {"en": "No more messages", "ar": "لا توجد رسائل أخرى"},
    "DATE_RANGE": {"en": "Date Range", "ar": "نطاق التاريخ"},
    "APPLY_FILTERS": {"en": "Apply Filters", "ar": "تطبيق الفلاتر"},
    "RESET_ALL": {"en": "Reset All", "ar": "إعادة ضبط الكل"},
    "RESET": {"en": "Reset", "ar": "إعادة ضبط"},
    "FROM": {"en": "From", "ar": "من"},
    "TO": {"en": "To", "ar": "إلى"},
    "ENTERR": {"en": 'Enter...', "ar": "...يدخل"},
    "END_DATE_REQUIRED": {
      "en": "End Date is required",
      "ar": "مطلوب تاريخ الانتهاء",
      "ta": "முடிவு தேதி தேவை",
    },
    "END_DATE_AFTER_START": {
      "en": "End Date must be after Start Date",
      "ar": "يجب أن يكون تاريخ الانتهاء بعد تاريخ البدء",
      "ta": "முடிவு தேதி தொடக்க தேதிக்கு பிறகு இருக்க வேண்டும்",
    },
    "MIN_LESS_THAN_MAX": {
      "en": "Min should be less than Max",
      "ar": "يجب أن يكون الحد الأدنى أقل من الحد الأقصى",
      "ta": "குறைந்தபட்சம் அதிகபட்சத்தைவிட குறைவாக இருக்க வேண்டும்",
    },
    "MAX_GREATER_THAN_MIN": {
      "en": "Max should be greater than Min",
      "ar": "يجب أن يكون الحد الأقصى أكبر من الحد الأدنى",
      "ta": "அதிகபட்சம் குறைந்தபட்சத்தைவிட அதிகமாக இருக்க வேண்டும்",
    },
    "SUPPORTED_FORMATS_HINT": {
      "en": "Supported formats: JPG, PNG, SVG | Max size: 2 MB",
      "ar": "الصيغ المدعومة: JPG، PNG، SVG | الحجم الأقصى: 2 ميغابايت",
    },
    "PASSPORT_NO": {"en": "Passport No.", "ar": "رقم جواز السفر"},
    "EMIRATES_NO": {"en": "Emirates No.", "ar": "رقم الهوية الإماراتية"},
    "GO_HOME": {"en": "Go Home", "ar": "اذهب إلى الصفحة الرئيسية"},
    "REDEEM": {"en": "Redeem", "ar": "استرد"},
    "VIEW_MORE": {"en": "View More", "ar": "عرض المزيد"},
    "SHOP_AND_EARN": {
      "en": "Make purchases at our partner stores and earn reward credits based on your spend. At checkout, share your contact details to receive your reward credits.\nRedeem your credits easily in the app under My Redemptions and enjoy exclusive offers and rewards from Shop & Win Lanka.",
      "ar": "إليك النص بعد إزالة علامات التنصيص المزدوجة:  تسوق من متاجر شركائنا واكسب نقاط مكافآت بناءً على إنفاقك. عند إتمام عملية الشراء، شارك بيانات الاتصال الخاصة بك لتلقي نقاط مكافآتك.استبدل نقاطك بسهولة عبر التطبيق ضمن قسم استرداداتي واستمتع بعروض ومكافآت حصرية من تسوق واربح لانكا."
    }
  };

  String get appLanguage => currentAppLanguage;

  void changeLanguage(String newLanguage) {
    if (currentAppLanguage != newLanguage) {
      currentAppLanguage = newLanguage;
      notifyListeners();
    }
  }

  String getTextValue(String key) {
    return _data[key]?[currentAppLanguage] ?? "Something went wrong";
  }
}