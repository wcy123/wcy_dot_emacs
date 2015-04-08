(nil
 (ignore (setq str (read-string "name: " (if (buffer-file-name) 
                                             (file-name-sans-extension
                                              (file-relative-name
                                               (buffer-file-name))) ""))))
"#include <v8.h>" ?\n
"#include <iostream>" ?\n
"using namespace std;" ?\n
"#include \"voba_utils.h\"" ?\n
"" ?\n
"static void " str "(const v8::FunctionCallbackInfo<Value>& args);" ?\n
"struct struct_" str " : public voba_ctor_base0<struct_" str "> {" ?\n
"  static void def(template_initializor_c& def){" ?\n
"    def(\"" _ "\", )" ?\n
"      ;" ?\n
"  }" ?\n
"};" ?\n
"static void " str "(const v8::FunctionCallbackInfo<Value>& args) " ?\n
"{" ?\n
"  args.GetReturnValue().Set(String::New(\"\"));" ?\n
"}" ?\n
"extern \"C\" void voba_init(Handle<Value>& ret) " ?\n
"{" ?\n
"  ret = struct_" str "::New();" ?\n
"  return;" ?\n
"}" ?\n
"" ?\n
)
  


;; Local Variables:
;; mode:emacs-lisp
;; coding: utf-8-unix
;; End:
