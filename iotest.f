        program outputdata   
        implicit none

        ! real, dimension(100) :: x, y  
        ! real, dimension(100) :: p, q
        integer :: i  
        real :: x, y
        
        ! Examine the lock
        logical :: file_exists
        INQUIRE(FILE="lock.file", EXIST=file_exists)

        ! while it's there
        do while (file_exists)
            write (*,*) "Found lockfile... waiting..."
            ! wait
            call sleep(1)
            INQUIRE(FILE="lock.file", EXIST=file_exists)
        end do
        
        ! then claim it
        open(12, file = 'lock.file', action = 'write')
        write (*,*) "Lock acquired!"
        
        ! output data into a file 
        write (*,*) "Sending data..."
        open(11, file = 'fortrandata', action = 'write', status = 'old')  
        do i=1,100000
            write(11,*) i * 0.1 , sin(i * 0.1) * (1-cos(i * 0.1/3.0))
        end do  
            
        close(11) 
        write (*,*) "Sending data... Done!"

        ! now read
        write (*,*) "Start reading data..."
        open(13, file = 'pythondata', status = 'old', action='read')  
        do i=1,10
            read(13,*) x, y
            write (*, *) "Received ", i, " => ", x, ':', y
        end do
            
        close(13) 
        write (*,*) "Reading data... Done!"

        ! Release the lock
        write (*,*) "Releasing the lock!"
        close(12)
        call unlink('lock.file')
        write (*,*) "Lock released! Exiting..."

        end program outputdata