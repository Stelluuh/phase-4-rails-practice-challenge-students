class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        render json: Student.all
    end

    def show
        student = find_students
        render json: student, status: :ok
    end

    def create
        new_student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = find_students
        student.update!(student_params)
        render json: student, status: :accepted
    end

    def destroy
        student = find_students
        student.destroy
        head :no_content
    end


        private

    def find_students
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age)
    end

    def render_not_found_response
        render json: { error: "Student not found"}, status: :not_found
    end

    def render_unprocessable_entity_response invalid
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end
end
