
  <div class="container">
    <div class="owl-carousel testimonial-carousel">
        <c:forEach var="maxim" items="${maxim}" varStatus="status" end="10">
          <div class="testimonial-wrap">
            <div class="testimonial">
              <blockquote>
                <br>
                <p>${maxim.contents}</p>
              </blockquote>
              <p>&mdash; ${maxim.name}</p>

            </div>
          </div>
        </c:forEach>
      </div>
  </div>
