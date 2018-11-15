;;;###autoload
(defun wcy-create-dpu-project(project-name interface-name)
  (interactive "MProject Name: MInterface Name: ")

  (let ((a 1))
    (with-temp-file "CMakeLists.txt"
      (apply 'insert
       `(
         "cmake_minimum_required(VERSION 3.5)
project(dp" ,project-name " VERSION 2.0.0 LANGUAGES C CXX)
set(OpenCV_LIBS opencv_core opencv_video opencv_videoio opencv_imgproc opencv_imgcodecs opencv_highgui)
list(APPEND CMAKE_MODULE_PATH \"${CMAKE_SYSROOT}/usr/share/cmake/\")
include(DeephiCommon)
include(DeephiVersion)
# include(DeephiDpu)
add_library(${PROJECT_NAME}
  include/" ,project-name ".hpp
  src/" ,project-name ".cpp
  src/" ,project-name "_imp.cpp
  src/" ,project-name "_imp.hpp
  ${CMAKE_BINARY_DIR}/version.c
  )
set_target_properties(${PROJECT_NAME} PROPERTIES
  VERSION \"${PROJECT_VERSION}\"
  SOVERSION \"${PROJECT_VERSION_MAJOR}\")
target_link_libraries(${PROJECT_NAME} dpbase dpmath glog pthread ${OpenCV_LIBS})
install(TARGETS ${PROJECT_NAME} DESTINATION lib)
install(FILES include/" ,project-name ".hpp DESTINATION include/deephi/" ,project-name ")

add_executable(test_" ,project-name " test/test_" ,project-name ".cpp)
target_link_libraries(test_" ,project-name " ${PROJECT_NAME} ${OpenCV_LIBS})

")))
    (make-directory "include" t)
    (with-temp-file (concat "include/" project-name ".hpp")
      (apply 'insert
       `(
         "#pragma once
#include <deephi/base/dpu/dpu_task.hpp>
#include <opencv2/core.hpp>

namespace deephi { namespace " ,project-name " {
struct " ,interface-name "Result {
};
class " ,interface-name " {
  public:
   static std::unique_ptr<" ,interface-name "> create();

  public:
   " ,interface-name "();
   " ,interface-name "(const " ,interface-name "&) = delete;
   virtual ~" ,interface-name "();

  public:
   virtual " ,interface-name "Result run(const cv::Mat& image) = 0;
};
} }
")))
    (make-directory "src" t)
    (with-temp-file (concat "src/" project-name ".cpp")
      (insert
       "#include \"../include/" project-name ".hpp\"
#include \"./" project-name "_imp.hpp\"

namespace  deephi {namespace " project-name " {
" interface-name "::" interface-name "() {}
" interface-name "::~" interface-name "() {}


std::unique_ptr<" interface-name "> " interface-name "::create() {
  return std::unique_ptr<" interface-name ">(new " interface-name "Imp());
}
}}
"))

    (with-temp-file (concat "src/" project-name "_imp.hpp")
      (insert "
#pragma once
#include \"../include/" project-name ".hpp\"
#include <deephi/base/dpu/dpu_task.hpp>

namespace deephi { namespace " project-name " {
class " interface-name "Imp :public " interface-name " {
  public:
    " interface-name "Imp();
    virtual ~" interface-name "Imp();

  private:
    virtual " interface-name "Result run(const cv::Mat& image) override;

};
} }


"))
    (with-temp-file (concat "src/" project-name "_imp.cpp")
      (insert
       "
#include \"./" project-name "_imp.hpp\"

namespace  deepCMakeLists.txthi {namespace " project-name " {

" interface-name "Imp::" interface-name "Imp() {}
" interface-name "Imp::~" interface-name "Imp() {}

" interface-name "Result " interface-name "Imp::run(const cv::Mat& image) {
  return " interface-name "Result{};
}

}}
"))

    (make-directory "test" t)
    (with-temp-file (concat "test/test_" project-name ".cpp")
      (insert "
#include \"../include/" project-name ".hpp\"
#include <iostream>
#include <memory>
#include <opencv2/core.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>

using namespace std;

int main(int argc, char *argv[])
{
    auto det = deephi::" project-name "::" interface-name "::create();
    auto image = cv::imread(argv[1]);
    if(image.empty()) {
        cerr << \"cannot load \" << argv[1] << endl;
        abort();
    }

    det->run(image);

    return 0;
}

"))
    ))
