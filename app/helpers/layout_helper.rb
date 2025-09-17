module LayoutHelper
  def module_partial(name)
    namespace = controller_path.split("/").first
    path = "#{namespace}/shared/#{name}"

    if lookup_context.exists?(path, [], true)
      path
    else
      "shared/#{name}" # fallback to global partials
    end
  end
end
