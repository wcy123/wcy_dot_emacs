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
#include <opencv2/core.hpp>
#include <memory>

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
    " interface-name "Imp(bool need_preprocess = true);
    virtual ~" interface-name "Imp();

  private:
    virtual " interface-name "Result run(const cv::Mat& image) override;
  private:
   std::unique_ptr<deephi::base::DpuTask> task_;
   std::vector<deephi::base::DpuLayerInput> layers_input_;
   std::vector<deephi::base::DpuLayerOutput> layers_output_;

};
} }


"))
    (with-temp-file (concat "src/" project-name "_imp.cpp")
      (insert
       "
#include \"./" project-name "_imp.hpp\"
#include <vector>
#include <deephi/base/profiling.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
using namespace std;
namespace  deephi {namespace " project-name " {

" interface-name "Imp::" interface-name "Imp(bool need_preprocess):
task_{deephi::base::DpuTask::create(\"<kernel-name>\",{\"<input-nodes>\"},{\"<output-nodes>\"})},
layers_input_{ task_->getLayerInputData() },
layers_output_{ task_->getLayerOutputData() }
{
     if(need_preprocess) {
          auto mean = vector<float>{128.0f, 128.0f, 128.0f};
          auto scale = vector<float>{1.0f, 1.0f, 1.0f};
          task_->setMeanScaleBGR(mean, scale);
     }
}
" interface-name "Imp::~" interface-name "Imp() {
}

" interface-name "Result " interface-name "Imp::run(const cv::Mat& input_image)
{
  cv::Mat image;
  if (layers_input_[0].width_ != (unsigned)input_image.cols ||
      layers_output_[0].height_ != (unsigned)input_image.rows) {
    cv::resize(input_image, image,
               cv::Size(layers_input_[0].width_, layers_input_[0].height_), 0,
               0, cv::INTER_NEAREST);
  } else {
    image = input_image;
  }
   __TIC__(" (upcase project-name) "_SET_IMG)
  task_->setImageBGR(image);
  __TOC__(" (upcase project-name) "_SET_IMG)

  __TIC__(" (upcase project-name) "_DPU)
  task_->run();
  __TOC__(" (upcase project-name) "_DPU)

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
