class StepCounter:
    def __init__(self):
        self.total_steps = 0

    def count_steps(self, steps):
        self.total_steps += steps

    def get_total_steps(self):
        return self.total_steps

# Example Usage:
# Uncomment the following lines to test the StepCounter class
 step_counter = StepCounter()
 step_counter.count_steps(1000)
 print(f"Total Steps: {step_counter.get_total_steps()}")

