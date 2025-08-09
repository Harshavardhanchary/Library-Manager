package com.cbit.LibraryManager.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cbit.LibraryManager.model.Book;
import com.cbit.LibraryManager.model.IssueBook;
import com.cbit.LibraryManager.model.SearchBook;
import com.cbit.LibraryManager.repository.LibraryRepository;

@Service
public class LibraryService {

    @Autowired
    private LibraryRepository repository;

    public String addBookService(Book book) throws Exception {
        int result = repository.addBookRepository(book);
        if (result > 0) {
            return "Book \"" + book.getbName() + "\" is added successfully";
        } else {
            return "Failed to add book \"" + book.getbName() + "\"";
        }
    }

public String issueBookService(IssueBook issueBook) throws Exception {
    // Check if student exists
    boolean studentExists = repository.studentExists(issueBook.getSid());
    if (!studentExists) {
        return "Cannot issue book " + issueBook.getBid() + ": Student " + issueBook.getSid() + " does not exist.";
    }

    String qualification = repository.getQualification(issueBook.getSid());
    int noOfBooks = repository.getNoOfBooksToIssue(qualification);
    int booksIssued = repository.getNoOfBooksIssued(issueBook.getSid());
    boolean isBookAvailable = repository.bookAvailabilityRepository(issueBook.getBid());
    String data = "";

    if (!isBookAvailable) {
        data = "Cannot issue book " + issueBook.getBid() + ": Book is not available.";
    } else if (booksIssued >= noOfBooks) {
        data = "Cannot issue book " + issueBook.getBid() + ": Student " + issueBook.getSid()
                + " has reached the limit of " + noOfBooks + " books.";
    } else {
        int count = repository.issueBookRepository(issueBook);
        if (count == 1) {
            data = "Book " + issueBook.getBid() + " is successfully issued to student " + issueBook.getSid() + ".";
        } else {
            data = "Error issuing book " + issueBook.getBid() + ": Please try again.";
        }
    }
    return data;
}


    public String returnBookService(IssueBook issueBook) throws Exception {
        String response;
        boolean isBookIssued = repository.isBookIssued(issueBook);

        if (isBookIssued) {
            int noOfDaysSinceIssued = repository.noOfDaysSinceIssued(issueBook.getBid());
            int noOfDaysAllowed = repository.noOfDaysCanBeIssued(issueBook.getSid());
            int fine = 0;

            if (noOfDaysSinceIssued > noOfDaysAllowed) {
                fine = (noOfDaysSinceIssued - noOfDaysAllowed) * 10;
            }

            int result = repository.returnBookRepository(issueBook);
            if (result == 1) {
                response = "Book " + issueBook.getBid() + " is returned successfully. Your fine is " + fine + " Rs.";
            } else {
                response = "Error in returning book " + issueBook.getBid() + ". Please try again.";
            }
        } else {
            response = "Book " + issueBook.getBid() + " was not issued to student " + issueBook.getSid() + ".";
        }
        return response;
    }

    public String searchBookService(SearchBook searchBook) throws Exception {
        return repository.searchBookRepo(searchBook);
    }
}
