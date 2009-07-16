  <master>

    <property name="context">@context;noquote@</property>
    <property name="&doc">doc</property>

    <if @show_button@ true>
      <div id="help-button">
        <ul class="action-list compact">
          <li><a href="/dotlrn/help/" class="button">#dotlrn.Back_to_index#</a></li>
        </ul>
      </div>
    </if>

    <div id="help-content">
      <slave>
    </div>
