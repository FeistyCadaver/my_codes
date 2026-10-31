#include <motiongl/linear_animator.hpp>
#include <utility> 
#include <vector>
int main() 
{ 
    const double x0 = 0.4; 
    const double v0 = 0.2; 
    const double duration = 5.0; 
    const double step = 0.01;
    
    sstd::vector<std::pair<double, double>> samples;

for (double t = 0.0; t <= duration; t += step) {
    const double x = x0 + v0 * t;
    samples.emplace_back(t, x);
}

mgl::LinearAnimator animator =
    mgl::LinearAnimatorBuilder()
        .size(1100, 640)
        .title("Physics Lab - Variant 3")
        .variant(3)
        .timeScale(1.0)
        .loop(true)
        .build();

animator.run(samples);

return 0;
}