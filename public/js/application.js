$(document).ready(function() {


$('.resp').on("click",function(e)
       {
        e.preventDefault()
        button = $(this)
        url = $(this)[0].parentElement.firstChild.splitText('/').parentElement.action
        var selValue = $('input[name=response]:checked').val();
        $.ajax({
          url: url,
          type: 'POST',
          dataType: 'json',
          data: {response:selValue}
         }).done(updateCallback);
        })

      
  $('.editprofile').on("click",function(e){
    updatemessage(e)
  });

   $('.contact').on("click",function(e){
    updatemessage(e)
  });

    $('.scoresubmit').on("click",function(e){
   updatemessage(e)
  });

       function updateCallback(response){
         // a = $('.container')
         // b = a.prepend(// a = $('.container')
         // b = a.prepend("<div class=temp><h1>Message sent Successfully!!</h1></div>"))
         
         // $('.temp').remove()
         alert("Confirmation Text sent")
          $(button)[0].parentElement.parentElement.remove()
          location.reload()
         
         }


         function updatemessage(e){
          alert("updated!")

         }

     
   });
