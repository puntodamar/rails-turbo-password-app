ActionView::Base.field_error_proc = proc do |html_tag, _instance|
    if html_tag.start_with?("<label")
        html_tag.html_safe
    else
        if html_tag =~ /class\s*=\s*"/
            html_tag.to_s.gsub(/class\s*=\s*"([^"]*)"/, 'class="\1 input-with-errors"').html_safe
        else
            html_tag.to_s.sub(/<\w+/, '\0 class="input-with-errors"').html_safe
        end
    end
end
