class MessageTemplatesController < ApplicationController

  def new
    @message_template = MessageTemplate.new
  end

  def create
    @message_template = MessageTemplate.new(template_params)
    if @message_template.save
      current_user.user_templates.create(message_template: @message_template)
      redirect_to mypage_path, success: '登録が完了しました'
    else
      redirect_to mypage_path, error: '登録できませんでした'
    end
  end

  def edit
    @template = MessageTemplate.find(params[:id])
    render turbo_stream: turbo_stream.replace("template_#{params[:id]}", partial: "message_templates/edit", locals: { template: @template })
  end
  
  def update
    @template = MessageTemplate.find(params[:id])
    if @template.update(template_params)
      redirect_to mypage_path, success: "テンプレートを更新しました"
    else
      redirect_to mypage_path, error: '更新できませんでした'
    end
  end

  def destroy
    @template = MessageTemplate.find(params[:id])
    @template.destroy
    render turbo_stream: turbo_stream.remove("template_#{params[:id]}") 
  end

  private

  def template_params
    params.require(:message_template).permit(:message)
  end
end

